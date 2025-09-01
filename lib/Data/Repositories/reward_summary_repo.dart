import 'package:mustadam/Data/Model/Coupon/CouponModel.dart';
import 'package:mustadam/Data/Model/Item/item_model.dart';
import 'package:mustadam/Data/Model/RewardSummary/RewardSummaryModel.dart';

import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';

class RewardSummaryRepo extends FirestoreRepo<RewardSummaryModel> {
  RewardSummaryRepo()
      : super(
          'Reward Summary',
        );

  @override
  RewardSummaryModel? toModel(Map<String, dynamic>? item) => RewardSummaryModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(RewardSummaryModel? item) => item?.toMap() ?? {};
}
