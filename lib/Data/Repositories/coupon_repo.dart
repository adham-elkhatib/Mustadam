import 'package:mustadam/Data/Model/Coupon/CouponModel.dart';
import 'package:mustadam/Data/Model/Item/item_model.dart';

import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';

class CouponRepo extends FirestoreRepo<CouponModel> {
  CouponRepo()
      : super(
          'Coupons',
        );

  @override
  CouponModel? toModel(Map<String, dynamic>? item) => CouponModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(CouponModel? item) => item?.toMap() ?? {};
}
