import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/components/audio_player.dart';
import 'package:local_voice_desktop/controllers/audios_controller.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class PageContent extends StatelessWidget {
  PageContent({
    super.key,
  });
  final AudiosController audiosController = Get.put(AudiosController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(() => SizedBox(
          height: size.height - navHeight,
          child: Padding(
            padding: EdgeInsets.all(max(size.width / 100, 10.0)),
            child: audiosController.currentAudio.isNotEmpty
                ? Column(
                    children: [
                      Text(
                        audiosController.currentAudio[0].id.toString(),
                        style: TextStyle(fontSize: textTitleSize),
                      ),
                      Text(
                        audiosController.currentAudio[0].audioUrl.toString(),
                        style: TextStyle(fontSize: textSize),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Audio transcriptions",
                            maxLines: 10,
                            style: TextStyle(fontSize: textSize),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Icon(Icons.edit),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hints:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                              "1. Use the Ctrl Key on the keyboard to play/pause."),
                          Text("2. Transribe all Errors as they are."),
                        ],
                      ),
                      const Spacer(),
                      if (audiosController.currentAudio.isNotEmpty)
                        AudioPlayer(audio: audiosController.currentAudio[0])
                      else
                        AudioPlayer(audio: null),
                      Container(
                        color: Colors.grey[100],
                        child: TextFormField(
                          cursorColor: Colors.black,
                          maxLines: 5,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                // borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                              hintText: "Trascription goes here."),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(onPressed: () {}, child: Text("Skip")),
                          OutlinedButton(onPressed: () {}, child: Text("Save")),
                        ],
                      )
                    ],
                  )
                : Text("Please choose audio from the side menu."),
          ),
        ));
  }
}
