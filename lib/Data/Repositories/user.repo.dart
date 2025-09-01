import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/User/user.model.dart';

class AppUserRepo extends FirestoreRepo<UserModel> {
  AppUserRepo() : super('Users');

  @override
  UserModel? toModel(Map<String, dynamic>? item) =>
      UserModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(UserModel? item) => item?.toMap() ?? {};
}
