import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/controllers/auth_controller.dart';
import 'package:local_voice_desktop/models/auth_response.dart';
import 'package:local_voice_desktop/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteServices {
  static var dio = Dio();
  AuthController authController = Get.put(AuthController());

  static Future<bool> setupAuthHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      dio.options.headers["Authorization"] = "Token $token";
      return true;
    }
    dio.options.headers.remove("Authorization");
    return false;
  }

  // User login
  static Future<AuthResponse?> loginUser(
      String emailAddress, String password) async {
    var data = {'email_address': emailAddress, 'password': password};
    final response = await dio.post("$BASE_URL/auth/login/", data: data);
    if (response.statusCode == 200) {
      // Save user in SharedPreference

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("authResponse", response.toString());
      return authResponseFromJson(response.toString());
    } else {
      // show error message
      print(response.statusCode.toString());
      return null;
    }
  }

  // User logout
  static Future<void> logoutUser() async {
    await dio.post("$BASE_URL/auth/logout/");
  }
}
