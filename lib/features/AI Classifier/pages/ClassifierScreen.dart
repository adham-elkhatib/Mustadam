import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustadam/Data/Repositories/leaderboard_repo.dart';

import '../../../Data/Model/LeaderboardModel.dart';
import '../../../Data/Model/User/college_enum.dart';
import 'MaterialTypeScreen.dart';

class ClassifierScreen extends StatefulWidget {
  const ClassifierScreen({super.key});

  @override
  ClassifierScreenState createState() => ClassifierScreenState();
}

class ClassifierScreenState extends State<ClassifierScreen> {
  File? _capturedImage;
  bool _loading = true;
  final List<LeaderboardModel> dummyLeaderboardData = [
    LeaderboardModel(
      id: '1',
      college: College.a6BusinessAdministration,
      imgUrl:
          'https://firebasestorage.googleapis.com/v0/b/mustadam-42e0d.firebasestorage.app/o/collages%2FWhatsApp%20Image%202025-04-19%20at%2019.32.38_f513a688.jpg?alt=media&token=95c29f01-1128-4b3c-871f-1718b54fb5ae',
      points: 120,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '2',
      college: College.a3Science,
      imgUrl:
          'https://firebasestorage.googleapis.com/v0/b/mustadam-42e0d.firebasestorage.app/o/collages%2FWhatsApp%20Image%202025-04-19%20at%2019.32.38_e288164b.jpg?alt=media&token=a21da816-f9ed-45bb-b378-2a4d2b01df21',
      points: 150,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '3',
      college: College.noCodeEducationAndHumanDevelopment,
      imgUrl:
          'https://firebasestorage.googleapis.com/v0/b/mustadam-42e0d.firebasestorage.app/o/collages%2FWhatsApp%20Image%202025-04-19%20at%2019.32.38_cab643d6.jpg?alt=media&token=9b0e90ed-aa05-4443-80a6-f44bd22dcf45',
      points: 90,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '4',
      college: College.a3ComputerAndInformationSystems,
      imgUrl:
          'https://firebasestorage.googleapis.com/v0/b/mustadam-42e0d.firebasestorage.app/o/collages%2FWhatsApp%20Image%202025-04-19%20at%2019.32.38_7a5af1be.jpg?alt=media&token=7ce34629-21d8-4287-bf95-58dd97215db1',
      points: 170,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '5',
      college: College.a1Medicine,
      imgUrl: 'https://example.com/medicine.png',
      points: 200,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '6',
      college: College.a2Pharmacy,
      imgUrl: 'https://example.com/pharmacy.png',
      points: 140,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '7',
      college: College.a2Dentistry,
      imgUrl: 'https://example.com/dentistry.png',
      points: 110,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '8',
      college: College.a10Law,
      imgUrl: 'https://example.com/law.png',
      points: 95,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '9',
      college: College.a5Languages,
      imgUrl: 'https://example.com/languages.png',
      points: 85,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '10',
      college: College.a8Engineering,
      imgUrl: 'https://example.com/engineering.png',
      points: 175,
      timestamp: DateTime.now(),
    ),
    LeaderboardModel(
      id: '11',
      college: College.a8ArtsAndDesigns,
      imgUrl:
          'https://firebasestorage.googleapis.com/v0/b/mustadam-42e0d.firebasestorage.app/o/collages%2FWhatsApp%20Image%202025-04-19%20at%2019.32.38_feaf3e58.jpg?alt=media&token=276959d4-c99c-4a8a-9843-669309ce5adc',
      points: 105,
      timestamp: DateTime.now(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // _uploadDummyLeaderboardData();
  }

  Future<void> _uploadDummyLeaderboardData() async {
    for (final model in dummyLeaderboardData) {
      await LeaderboardRepo().createSingle(model, itemId: model.id);
    }
  }

  Future<void> _openCameraOnStart() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      setState(() {
        _capturedImage = File(pickedImage.path);
        _loading = false;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MaterialTypeScreen(imageFile: _capturedImage!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Classifier')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.grey[300],
              child: IconButton(
                icon: const Icon(Icons.camera_alt),
                iconSize: 40,
                onPressed: _openCameraOnStart,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
