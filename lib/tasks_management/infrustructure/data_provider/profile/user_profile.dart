import 'package:platform_x/lib.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/data_provider.dart';

class UserProfileDataProvider extends DataProvider {
  final Dio dio;

  UserProfileDataProvider({required this.dio});

  Future<Map<String, String>> loadUserProfile() async {
    try {

      print("called");
      
      var pref = await SharedPreferences.getInstance();
      String? profileID = pref.getString("profile_id");

      if (profileID == null){
        throw Exception("no profile id found");
      }

      Response response = await dio.get(
        "/v1/user/data-collector-profiles/$profileID",
      );

      print(response);

      if (response.statusCode != 200) {
        throw Exception("Error while submitting answers.");
      }

      Map<String, String> data =  {
        "firstName": response.data['user']['first_name'],
        "lastName": response.data['user']['last_name'],
        "profileImage": response.data['profile_picture'],
      };

      print(data);

      return data;

    } catch (e) {
      print("@Error: $e");
      rethrow;
    }
  }

}
