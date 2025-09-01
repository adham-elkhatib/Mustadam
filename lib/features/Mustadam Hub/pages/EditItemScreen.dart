import 'package:flutter/material.dart';
import 'package:mustadam/Data/Repositories/Item_repo.dart';

import '../../../Data/Model/Item/item_model.dart';
import '../../../core/widgets/primary_button.dart';

class EditItemScreen extends StatefulWidget {
  final ItemModel item;

  const EditItemScreen({super.key, required this.item});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController nameController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item.name);
    descController = TextEditingController(text: widget.item.description);
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    super.dispose();
  }

  void saveChanges() async {
    final updatedItem = widget.item.copyWith(
      name: nameController.text,
      description: descController.text,
    );

    await ItemRepo().updateSingle(widget.item.id, updatedItem);

    if (!mounted) return;
    Navigator.pop(context, updatedItem); // نرجّع الـ item المعدل
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Item updated')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Item Name'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            PrimaryButton(title: 'Save', onPressed: saveChanges),
          ],
        ),
      ),
    );
  }
}
