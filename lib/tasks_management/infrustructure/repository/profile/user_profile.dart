import '../../../domain/questionTypes.dart';
import '../../data_provider/profile/user_profile.dart';

class UserProfileRepository {
  final UserProfileDataProvider userDataProvider;

  UserProfileRepository({required this.userDataProvider});

  Future<Map<String, String>> loadUserProfile() async {
    try {
      Map<String, String> profile =  await userDataProvider.loadUserProfile();
      return profile;
    } catch (e) {
      rethrow;
    }
  }
}