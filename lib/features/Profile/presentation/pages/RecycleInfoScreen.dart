import 'package:flutter/material.dart';

class RecycleInfoScreen extends StatelessWidget {
  const RecycleInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recycling Info')),
      body: Center(
        child: Image.asset(width: double.infinity, 'assets/images/info.jpg'),
      ),
    );
  }
}
