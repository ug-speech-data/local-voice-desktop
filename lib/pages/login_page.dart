import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/controllers/auth_controller.dart';
import 'package:local_voice_desktop/pages/home_page.dart';
import 'package:local_voice_desktop/pages/menu_page.dart';
import 'package:local_voice_desktop/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  bool _validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 500,
          height: 500,
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "UG SPEECH DATA",
                  style: TextStyle(fontSize: textTitleSize),
                ),
                const Text("Log in to access our server resources."),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 2) {
                        return "Please enter a valid username.";
                      }
                      return null;
                    },
                    style: TextStyle(fontSize: 18),
                    onChanged: (text) {
                      username = text;
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      labelStyle: TextStyle(fontSize: 18),
                      hintStyle: TextStyle(fontSize: 18),
                      hintText: 'Username',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password.";
                      }
                      return null;
                    },
                    obscureText: hidePassword,
                    autocorrect: false,
                    onChanged: (text) {
                      password = text;
                    },
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      labelStyle: const TextStyle(fontSize: 18),
                      hintStyle: const TextStyle(
                        fontSize: 18,
                      ),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        icon: Icon(hidePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: !isApiCallProcess
                          ? () {
                              if (_validateAndSave()) {
                                // Hide progressbar
                                setState(() {
                                  isApiCallProcess = true;
                                });

                                // Make login API Call
                                authController
                                    .loginUser(username, password)
                                    .then((value) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  // If login succeeds
                                  if (value?.token != null) {
                                    _saveToken(value!.token!);
                                    Get.to(MenuPage());
                                  } else if (value?.errorMessage != null) {
                                    Get.snackbar(
                                        "Failed!", value!.errorMessage!,
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 2),
                                        maxWidth: 400,
                                        margin: const EdgeInsets.all(20),
                                        animationDuration:
                                            const Duration(milliseconds: 200),
                                        backgroundColor: colorError);
                                  } else {
                                    Get.snackbar(
                                        "Failed!", "Unknown error occured.",
                                        colorText: Colors.white,
                                        duration: const Duration(seconds: 2),
                                        maxWidth: 400,
                                        margin: const EdgeInsets.all(20),
                                        animationDuration:
                                            const Duration(milliseconds: 200),
                                        backgroundColor: colorError);
                                  }
                                });
                              }
                            }
                          : null,
                      child: isApiCallProcess
                          ? const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20.0,
                            )
                          : const Text("Login")),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(title: ""),
                          ),
                        );
                      },
                      child: const Text("Skip")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
