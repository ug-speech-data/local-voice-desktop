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
          // App Bar
          AppNavBar(),
          InkWell(
            onTap: () {
              appController.taskType.value = TaskType.trancription.value;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: ""),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Text("Transcription"),
            ),
          ),
          InkWell(
            onTap: () {
              appController.taskType.value = TaskType.resolution.value;

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: ""),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              child: const Text("Transcription Resolution"),
            ),
          ),
          // Main page
        ],
      ),
    );
  }
}
