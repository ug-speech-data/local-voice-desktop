import 'package:get/get.dart';
import 'package:local_voice_desktop/models/auth_response.dart';
import 'package:local_voice_desktop/services/remote_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = true.obs;
  Rx<AuthResponse?> authResponse = AuthResponse().obs;
  RxString userResponse = "".obs;

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("authResponse");
    authResponse.value = AuthResponse();

    try {
      await RemoteServices.logoutUser();
    } on Exception catch (_) {}
  }

  String getUserName() {
    String? surname = authResponse.value?.user?.surname;
    String? otherNames = authResponse.value?.user?.otherNames;
    String fullname = "";
    if (surname != null) {
      fullname += fullname;
    }
    if (otherNames != null) {
      fullname += " $otherNames";
    }
    return fullname;
  }

  Future<AuthResponse?> loginUser(String emailAddress, String password) async {
    try {
      isLoading(true);
      AuthResponse? response =
          await RemoteServices.loginUser(emailAddress, password);
      authResponse.value = response;
      return response;
    } on Exception catch (e) {
      print("Exception $e");
    } finally {
      isLoading(false);
    }
    return null;
  }
}
