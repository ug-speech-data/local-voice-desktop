import 'package:get/get.dart';
import 'package:local_voice_desktop/models/auth_response.dart';
import 'package:local_voice_desktop/services/remote_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = true.obs;
  Rx<AuthResponse?> authResponse = AuthResponse().obs;
  RxString userResponse = "".obs;
  RxString username = "".obs;

  @override
  void onInit() async {
    await getUserName();
    super.onInit();
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    prefs.remove("authResponse");
    authResponse.value = AuthResponse();

    try {
      await RemoteServices.logoutUser();
    } on Exception catch (_) {}
  }

  Future<String> getUserName() async {
    String fullname = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authRes = prefs.getString('authResponse');
    if (authRes != null) {
      var response = authResponseFromJson(authRes);
      String? surname = response.user?.surname;
      String? otherNames = response.user?.otherNames;
      if (surname != null) {
        fullname += fullname;
      }
      if (otherNames != null) {
        fullname += " $otherNames";
      }
    }
    username.value = fullname;
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
