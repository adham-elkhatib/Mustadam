import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Data/Model/Item/item_model.dart';
import '../../../core/widgets/primary_button.dart';
import '../pages/item_details_screen.dart';

class ItemCard extends StatelessWidget {
  final ItemModel item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // 🖼 صورة العنصر
            Image.network(
              item.imageUrl,
              width: 60,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Container(
                    width: 60,
                    height: 80,
                    color: Colors.grey[300],
                    child: Icon(Icons.image_not_supported),
                  ),
            ),

            const SizedBox(width: 12),

            // 📄 تفاصيل العنصر
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    item.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      final userId = FirebaseAuth.instance.currentUser?.uid;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ItemDetailsScreen(
                                item: item,
                                currentUserId: userId!,
                              ),
                        ),
                      );
                    },

                    child: const Text(
                      'More details',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // 📞 زرار التواصل
            PrimaryButton(
              title: 'Contact',
              onPressed: () async {
                var phone = item.contactLink;

                var androidUrl =
                    "whatsapp://send?phone=$phone&text=Hi, I need buy ${item.name} listed on Mustadam Hub";
                await launchUrl(Uri.parse(androidUrl));
              },
            ),
          ],
        ),
      ),
    );
  }
}
