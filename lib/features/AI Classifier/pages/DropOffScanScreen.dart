import 'dart:io';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mustadam/Data/Repositories/user.repo.dart';
import 'package:mustadam/core/Providers/src/condition_model.dart';
import 'package:mustadam/core/Services/Id%20Generating/id_generating.service.dart';
import 'package:mustadam/features/AI%20Classifier/pages/thank_you_screen.dart';

import '../../../Data/Model/LeaderboardModel.dart';
import '../../../Data/Model/Recycle/RecycleHistoryModel.dart';
import '../../../Data/Model/RewardSummary/RewardSummaryModel.dart';
import '../../../Data/Repositories/leaderboard_repo.dart';
import '../../../Data/Repositories/recycle_history_repo.dart';
import '../../../Data/Repositories/reward_summary_repo.dart';

class DropOffScanScreen extends StatefulWidget {
  final String materialType;
  final File imageFile;

  const DropOffScanScreen({
    super.key,
    required this.materialType,
    required this.imageFile,
  });

  @override
  _DropOffScanScreenState createState() => _DropOffScanScreenState();
}

class _DropOffScanScreenState extends State<DropOffScanScreen> {
  bool scanned = false;
  bool isLoading = false;

  final List<String> validBins = List.generate(10, (i) => 'A${i + 1}');

  Future<String> uploadImage(File imageFile) async {
    final fileName =
        'recycle_images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final ref = FirebaseStorage.instance.ref().child(fileName);

    await ref.putFile(imageFile);
    return await ref.getDownloadURL();
  }

  Future<void> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      final raw = result.rawContent.trim();

      if (raw.isEmpty) return;
      setState(() {
        scanned = true;
        isLoading = true;
      });
      // 🧩 تقسيم الباركود
      final parts = raw.split('-');
      if (parts.length != 2) {
        showError("Invalid barcode format. Example: A1 - plastic");
        return;
      }

      final bin = parts[0].trim().toUpperCase();
      final material = parts[1].trim().toLowerCase();

      // ✅ تحقق من صلاحية البين
      if (!validBins.contains(bin)) {
        showError("Bin $bin is not recognized.");
        return;
      }

      // ✅ تحقق من نوع المادة
      if (material != widget.materialType.toLowerCase()) {
        showError(
          "Scanned material '$material' does not match expected '${widget.materialType}'",
        );
        return;
      }

      // 🎯 نجاح: إضافة النقاط للمستخدم والكلية
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final user = await AppUserRepo().readSingle(userId);
      if (user == null) return;

      final updatedUser = user.copyWith(totalPoints: user.totalPoints + 5);

      final rewardSummaryModel = RewardSummaryModel(
        id: IdGeneratingService.generate(),
        totalPoints: updatedUser.totalPoints,
        redeemedPoints: 5,
        userId: userId,
        dateTime: DateTime.now(),
      );

      final leaderboardModels = await LeaderboardRepo().readAllWhere([
        QueryCondition.equals(field: "college", value: user.college.index),
      ], limit: 1);

      if (leaderboardModels!.isNotEmpty) {
        final leaderboard = leaderboardModels.first as LeaderboardModel;
        final updatedLeaderboard = leaderboard.copyWith(
          points: leaderboard.points + 5,
        );
        await LeaderboardRepo().updateSingle(
          updatedLeaderboard.id,
          updatedLeaderboard,
        );
      }

      await RewardSummaryRepo().createSingle(
        rewardSummaryModel,
        itemId: rewardSummaryModel.id,
      );
      final imageUrl = await uploadImage(widget.imageFile);

      final recycleHistoryModel = RecycleHistoryModel(
        id: IdGeneratingService.generate(),
        userId: userId,
        category: material,
        itemName: material,
        location: bin,
        imageUrl: imageUrl,
        points: 5,
        recycledAt: DateTime.now(),
      );

      await RecycleHistoryRepo().createSingle(
        recycleHistoryModel,
        itemId: recycleHistoryModel.id,
      );

      // ✅ الانتقال لصفحة الشكر
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => ThankYouScreen(userName: user.name)),
      );
    } catch (e) {
      showError("Scanning failed: ${e.toString()}");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
    setState(() {
      scanned = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Drop off item')),
      body:
          isLoading
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text("Uploading your data... Please wait"),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Scan the bin barcode'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: scanned ? null : scanBarcode,
                        icon: const Icon(Icons.qr_code_scanner),
                        label: const Text('Scan Now'),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
