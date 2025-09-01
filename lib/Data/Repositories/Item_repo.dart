import 'package:mustadam/Data/Model/Item/item_model.dart';

import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';

class ItemRepo extends FirestoreRepo<ItemModel> {
  ItemRepo()
      : super(
          'Items',
        );

  @override
  ItemModel? toModel(Map<String, dynamic>? item) => ItemModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(ItemModel? item) => item?.toMap() ?? {};
}
