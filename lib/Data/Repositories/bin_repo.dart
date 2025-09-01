import 'package:mustadam/Data/Model/BinModel.dart';

import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';

class BinRepo extends FirestoreRepo<BinModel> {
  BinRepo() : super('Bins');

  @override
  BinModel? toModel(Map<String, dynamic>? item) => BinModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(BinModel? item) => item?.toMap() ?? {};
}
