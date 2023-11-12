import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/components/app_nav_bar.dart';
import 'package:local_voice_desktop/controllers/app_controller.dart';
import 'package:local_voice_desktop/pages/home_page.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class MenuPage extends StatelessWidget {
  MenuPage({super.key});

  final AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          AppNavBar(),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Would you like to do?"),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        appController.taskType.value =
                            TaskType.trancription.value;
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const MyHomePage(title: ""),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: 300,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.grey[100],
                        child: const Text(
                          "Transcription",
                          style: TextStyle(
                              color: Colors.black, fontSize: textSize),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        appController.taskType.value =
                            TaskType.resolution.value;
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) =>
                                const MyHomePage(title: ""),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: 300,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.grey[100],
                        child: const Text(
                          "Transcription Resolution",
                          style: TextStyle(
                              color: Colors.black, fontSize: textSize),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Main page
        ],
      ),
    );
  }
}
