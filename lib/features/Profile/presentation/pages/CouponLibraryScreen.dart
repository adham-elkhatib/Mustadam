import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mustadam/core/widgets/primary_button.dart';
import 'package:mustadam/core/widgets/section_placeholder.dart';

import '../../../../Data/Model/Coupon/CouponModel.dart';
import '../../../../Data/Model/RewardSummary/RewardSummaryModel.dart';
import '../../../../Data/Repositories/coupon_repo.dart';
import '../../../../Data/Repositories/reward_summary_repo.dart';
import '../../../../Data/Repositories/user.repo.dart';
import '../../../../core/Services/Id Generating/id_generating.service.dart';

class CouponLibraryScreen extends StatefulWidget {
  const CouponLibraryScreen({super.key});

  @override
  State<CouponLibraryScreen> createState() => _CouponLibraryScreenState();
}

class _CouponLibraryScreenState extends State<CouponLibraryScreen> {
  String searchText = '';
  final TextEditingController searchController = TextEditingController();
  late Future<List<CouponModel?>?> _futureCoupons;

  @override
  void initState() {
    super.initState();
    _futureCoupons = CouponRepo().readAll();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _showPointOptionsDialog(CouponModel coupon) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Use ${coupon.name}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPointOption(coupon, 50, "10%"),
              _buildPointOption(coupon, 75, "15%"),
              _buildPointOption(coupon, 100, "20%"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPointOption(CouponModel coupon, int points, String discount) {
    return ListTile(
      title: Text('$points points for $discount'),
      trailing: ElevatedButton(
        child: const Text("Select"),
        onPressed: () {
          Navigator.pop(context);
          _generateCouponQR(coupon, points, discount);
        },
      ),
    );
  }

  void _generateCouponQR(
    CouponModel coupon,
    int points,
    String discount,
  ) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    final user = await AppUserRepo().readSingle(userId);
    if (user == null) return;

    final newPoints = user.totalPoints - points;
    if (newPoints < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You don't have enough points."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 🔻 خصم النقاط
    final updatedUser = user.copyWith(totalPoints: newPoints);
    await AppUserRepo().updateSingle(updatedUser.id, updatedUser);

    // 🧾 عملية بالسالب
    final summary = RewardSummaryModel(
      id: IdGeneratingService.generate(),
      totalPoints: newPoints,
      redeemedPoints: -points,
      userId: userId,
      dateTime: DateTime.now(),
    );
    await RewardSummaryRepo().createSingle(summary, itemId: summary.id);

    // 🎉 عرض QR Code عشوائي
    final qrCodeText =
        "${coupon.name}-${DateTime.now().millisecondsSinceEpoch}";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Your QR Code"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(
                "https://api.qrserver.com/v1/create-qr-code/?data=$qrCodeText&size=200x200",
                errorBuilder: (_, __, ___) => const Icon(Icons.qr_code),
              ),
              const SizedBox(height: 12),
              Text("Show this at checkout to redeem $discount"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coupon Library')),
      body: FutureBuilder<List<CouponModel?>?>(
        future: _futureCoupons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SectionPlaceholder(title: 'No coupons available.'),
              ),
            );
          }

          final coupons = snapshot.data!;
          final filteredCoupons =
              coupons.where((coupon) {
                final matchesSearch = coupon?.name.toLowerCase().contains(
                  searchText.toLowerCase(),
                );

                return matchesSearch!;
              }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by name',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child:
                    filteredCoupons.isEmpty
                        ? const Center(
                          child: Text("No matching coupons found."),
                        )
                        : ListView.builder(
                          itemCount: filteredCoupons.length,
                          itemBuilder: (context, index) {
                            final coupon = filteredCoupons[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        coupon!.imageUrl,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(Icons.broken_image),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            coupon.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    PrimaryButton(
                                      onPressed:
                                          () => _showPointOptionsDialog(coupon),
                                      title: 'Use',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
      ),
    );
  }
}
