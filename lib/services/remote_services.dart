import 'package:dio/dio.dart' as dio_lib;
import 'package:get/get.dart';
import 'package:local_voice_desktop/controllers/auth_controller.dart';
import 'package:local_voice_desktop/models/auth_response.dart';
import 'package:local_voice_desktop/models/transcription_audio.dart';
import 'package:local_voice_desktop/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteServices {
  static var dio = dio_lib.Dio();
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

  static Future<bool> removeAuthHeader() async {
    dio.options.headers.remove("Authorization");
    return false;
  }

  // User login
  static Future<AuthResponse?> loginUser(
      String emailAddress, String password) async {
    removeAuthHeader();

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

  // Get audios to transcribe
  static Future<dio_lib.Response> getAudiosToTranscribe(bool completed) async {
    await setupAuthHeader();
    return await dio.get("$BASE_URL/get-assigned-audios-to-transcribe");
  }

  // Get transcriptions to resolve
  static Future<dio_lib.Response> getTranscriptionsToResolve(
      bool completed) async {
    await setupAuthHeader();
    return await dio.get("$BASE_URL/get-assigned-transcriptions-to-resolve/");
  }

  static Future<dio_lib.Response> submitTranscriptionResolution(
      TranscriptionAudio audio) async {
    await setupAuthHeader();
    var data = {
      'id': audio.id,
      'text': audio.transcribedText,
      "transcription_status": "accepted"
    };
    return await dio.post("$BASE_URL/get-transcription-to-resolve/",
        data: data);
  }

  // Get audios to transcribe
  static Future<dio_lib.Response> uploadTranscription(
      TranscriptionAudio audio) async {
    await setupAuthHeader();

    var data = {'id': audio.id, 'text': audio.transcribedText};
    return await dio.post("$BASE_URL/submit-transcription/", data: data);
  }
}
