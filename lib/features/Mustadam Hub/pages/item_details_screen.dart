import 'package:flutter/material.dart';
import 'package:mustadam/Data/Model/Item/item_model.dart';
import 'package:mustadam/core/widgets/primary_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/Repositories/Item_repo.dart';
import 'EditItemScreen.dart';

class ItemDetailsScreen extends StatefulWidget {
  final ItemModel item;
  final String currentUserId;

  const ItemDetailsScreen({
    super.key,
    required this.item,
    required this.currentUserId,
  });

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  late ItemModel item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  void _navigateToEditScreen() async {
    final updatedItem = await Navigator.push<ItemModel>(
      context,
      MaterialPageRoute(builder: (_) => EditItemScreen(item: item)),
    );

    if (updatedItem != null) {
      setState(() {
        item = updatedItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Item Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼 صورة كبيرة
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder:
                    (_, __, ___) => Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image_not_supported),
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 16),

            // 🧾 اسم ووصف
            Text(
              item.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(item.description),
            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.category, size: 20),
                const SizedBox(width: 8),
                Text(item.category.label),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, size: 20),
                const SizedBox(width: 8),
                Text('Owner: ${item.ownerId}'),
              ],
            ),
            const SizedBox(height: 24),

            if (item.ownerId == widget.currentUserId)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _navigateToEditScreen,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder:
                            (_) => AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                'Are you sure you want to delete this item?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed:
                                      () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                      );

                      if (confirm == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Item deleted')),
                        );
                        await ItemRepo().deleteSingle(item.id);
                        Navigator.pop(context, 'deleted');
                      }
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 24),

            Center(
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  title: 'Contact on WhatsApp',
                  onPressed: () async {
                    var phone = item.contactLink;
                    var androidUrl =
                        "whatsapp://send?phone=$phone&text=Hi, I need buy ${item.name} listed on Mustadam Hub";
                    await launchUrl(Uri.parse(androidUrl));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
