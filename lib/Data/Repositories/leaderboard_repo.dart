import '../../core/Providers/FB Firestore/fbfirestore_repo.dart';
import '../Model/LeaderboardModel.dart';

class LeaderboardRepo extends FirestoreRepo<LeaderboardModel> {
  LeaderboardRepo() : super('Leaderboard');

  @override
  LeaderboardModel? toModel(Map<String, dynamic>? item) =>
      LeaderboardModel.fromMap(item ?? {});

  @override
  Map<String, dynamic>? fromModel(LeaderboardModel? item) =>
      item?.toMap() ?? {};
}
