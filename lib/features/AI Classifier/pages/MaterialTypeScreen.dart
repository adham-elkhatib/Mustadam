import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mustadam/core/widgets/primary_button.dart';

import '../../../constants.dart';
import 'DropOffScanScreen.dart';

class MaterialTypeScreen extends StatefulWidget {
  final File imageFile;

  const MaterialTypeScreen({super.key, required this.imageFile});

  @override
  State<MaterialTypeScreen> createState() => _MaterialTypeScreenState();
}

class _MaterialTypeScreenState extends State<MaterialTypeScreen> {
  bool isLoading = true;
  String? predictedLabel;

  @override
  void initState() {
    super.initState();
    classifyImage();
  }

  Future<void> classifyImage() async {
    setState(() {
      isLoading = true;
    });

    var uri = Uri.parse('http://$ip:$port/predict');
    var request = http.MultipartRequest('POST', uri)
      ..files.add(
        await http.MultipartFile.fromPath('file', widget.imageFile.path),
      );

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var decoded = json.decode(responseBody);
        setState(() {
          predictedLabel = decoded['predicted'];
          isLoading = false;
        });
      } else {
        setState(() {
          predictedLabel = 'Error occurred';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        predictedLabel = 'Failed to connect to API';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Classifier')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(widget.imageFile),
                        ),
                        title: const Text('Material Type'),
                        subtitle: Text(
                          predictedLabel ?? 'Unknown',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text('Do you want to'),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => DropOffScanScreen(
                                    materialType: predictedLabel!,
                                    imageFile: widget.imageFile,
                                  ),
                            ),
                          );
                        },
                        title: 'Drop off item',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
