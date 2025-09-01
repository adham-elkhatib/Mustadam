import 'package:mustadam/Data/Model/Coupon/CouponModel.dart';
import 'package:mustadam/Data/Model/Item/item_model.dart';
import 'package:mustadam/Data/Model/Recycle/RecycleHistoryModel.dart';

import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';

class RecycleHistoryRepo extends FirestoreRepo<RecycleHistoryModel> {
  RecycleHistoryRepo()
      : super(
          'Recycle History',
        );

  @override
  RecycleHistoryModel? toModel(Map<String, dynamic>? item) => RecycleHistoryModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(RecycleHistoryModel? item) => item?.toMap() ?? {};
}
