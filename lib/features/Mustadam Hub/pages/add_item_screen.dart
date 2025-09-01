import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mustadam/Data/Repositories/Item_repo.dart';
import 'package:mustadam/Data/Repositories/user.repo.dart';
import 'package:mustadam/core/Services/Id%20Generating/id_generating.service.dart';
import 'package:mustadam/core/utils/SnackBar/snackbar.helper.dart';
import 'package:mustadam/core/widgets/primary_button.dart';

import '../../../Data/Model/Item/item_category.dart';
import '../../../Data/Model/Item/item_model.dart';
import '../../../core/Services/Auth/auth.service.dart';
import '../../../core/Services/Auth/src/Providers/auth_provider.dart';
import '../../../core/Services/Firebase Storage/firebase_storage.service.dart';
import '../../../core/Services/Firebase Storage/src/models/storage_file.model.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();

  File? selectedImage;
  String? imageUrl;
  bool isLoading = false;

  ItemCategory selectedCategory = ItemCategory.book;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedImage == null) {
      SnackbarHelper.showError(context, title: "Please select an image first");
      return;
    }

    setState(() => isLoading = true);

    try {
      final bytes = await selectedImage!.readAsBytes();
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final storageFile = StorageFile(
        data: bytes,
        fileName: fileName,
        fileExtension: 'jpg',
      );

      final task = FirebaseStorageService.uploadSingle('items', storageFile);
      final snapshot = await task;
      final url = await snapshot?.ref.getDownloadURL();
      imageUrl = url;

      final userId =
          AuthService(
            authProvider: FirebaseAuthProvider(
              firebaseAuth: FirebaseAuth.instance,
            ),
          ).getCurrentUserId();

      final user = await AppUserRepo().readSingle(userId!);
      String Id = IdGeneratingService.generate();
      final newItem = ItemModel(
        id: Id,
        name: nameController.text.trim(),
        description: descriptionController.text.trim(),
        category: selectedCategory,
        imageUrl: imageUrl!,
        contactLink: phoneNumberController.text.trim(),
        ownerId: user!.id,
        ownerName: user.name,
        timestamp: DateTime.now(),
      );

      await ItemRepo().createSingle(newItem, itemId: newItem.id);

      if (!mounted) return;
      SnackbarHelper.showTemplated(context, title: "✅ New Item Added!");
      Navigator.pop(context);
    } catch (e) {
      SnackbarHelper.showError(context, title: "Something went wrong 😢");
      debugPrint("❌ $e");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child:
                      selectedImage != null
                          ? Image.file(selectedImage!, fit: BoxFit.cover)
                          : const Icon(
                            Icons.add_a_photo,
                            size: 50,
                            color: Colors.grey,
                          ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Item Name',
                ),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ItemCategory>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
                items:
                    ItemCategory.values.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category.label),
                      );
                    }).toList(),
                onChanged: (val) => setState(() => selectedCategory = val!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact Number (e.g., WhatsApp)',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }
                  const pattern = r'^\966\s?5\d{1}\s?\d{3}\s?\d{4}$';
                  if (!RegExp(pattern).hasMatch(value.trim())) {
                    return 'Enter a valid Saudi number (e.g. +966 55 123 4567)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              if (isLoading) ...[
                const Text(
                  "Uploading...",
                  style: TextStyle(color: Colors.teal),
                ),
                const SizedBox(height: 12),
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
              ],

              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: isLoading ? () {} : _submit,

                  title: 'Add to Mustadam Hub',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
