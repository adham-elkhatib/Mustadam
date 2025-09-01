import 'package:flutter/material.dart';
import 'package:mustadam/core/widgets/section_placeholder.dart';

import '../../../Data/Model/Item/item_model.dart';
import '../../../Data/Model/shared/SortOrder.dart';
import '../../../Data/Repositories/Item_repo.dart';
import '../widgets/item_card.dart';
import 'add_item_screen.dart';

class ItemsListScreen extends StatefulWidget {
  const ItemsListScreen({super.key});

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  TextEditingController searchController = TextEditingController();
  List<ItemModel?>? allItems = [];
  List<ItemModel?>? filteredItems = [];
  bool isLoading = true;
  SortOrder sortOrder = SortOrder.newestFirst;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _applySort() {
    if (filteredItems == null) return;
    filteredItems!.sort((a, b) {
      if (sortOrder == SortOrder.newestFirst) {
        return b!.timestamp.compareTo(a!.timestamp);
      } else {
        return a!.timestamp.compareTo(b!.timestamp);
      }
    });
  }

  Future<void> _loadItems() async {
    final items = await ItemRepo().readAll();
    setState(() {
      allItems = items;
      filteredItems = items;
      _applySort();
      isLoading = false;
    });
  }

  void _filterItems(String query) {
    final lower = query.toLowerCase();
    setState(() {
      filteredItems =
          allItems
              ?.where((item) => item!.name.toLowerCase().contains(lower))
              .toList();
      _applySort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mustadam Hub')),
      body: Column(
        children: [
          // 🔍 Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchController,
              onChanged: _filterItems,
              decoration: InputDecoration(
                hintText: 'Search by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 📤 Filter & Add Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      sortOrder =
                          sortOrder == SortOrder.newestFirst
                              ? SortOrder.oldestFirst
                              : SortOrder.newestFirst;
                      _applySort();
                    });
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list),
                      const SizedBox(width: 8),
                      Text(
                        sortOrder == SortOrder.newestFirst
                            ? "Sort by Newest"
                            : "Sort by Oldest",
                      ),
                      const Icon(Icons.swap_vert),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Spacer(),
                FloatingActionButton.small(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const AddItemScreen(),
                      ),
                    ).then((_) => _loadItems()); // Reload items after adding
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          if (isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (filteredItems!.isEmpty)
            const Expanded(child: SectionPlaceholder(title: "No items found"))
          else
            Expanded(
              child: ListView.builder(
                itemCount: filteredItems?.length,
                itemBuilder: (context, index) {
                  return ItemCard(item: filteredItems![index]!);
                },
              ),
            ),
        ],
      ),
    );
  }
}
