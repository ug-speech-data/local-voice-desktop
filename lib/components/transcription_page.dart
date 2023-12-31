import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/components/audio_player.dart';
import 'package:local_voice_desktop/controllers/audios_controller.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class TranscriptionPage extends StatefulWidget {
  const TranscriptionPage({
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _TranscriptionPageState();
}

class _TranscriptionPageState extends State<TranscriptionPage> {
  final AudiosController audiosController = Get.put(AudiosController());
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    if (audiosController.currentAudio.isNotEmpty) {
      _controller = TextEditingController(
          text: audiosController.currentAudio[0].getText());
    } else {
      _controller = TextEditingController(text: "");
    }
  }

  void _nextAudio() {
    var index =
        audiosController.audios.indexOf(audiosController.currentAudio[0]);
    audiosController.currentAudio[0] = audiosController.audios[index + 1];
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Obx(() {
      _controller.value = const TextEditingValue(text: "");

      return SizedBox(
        height: size.height - navHeight,
        child: Padding(
          padding: EdgeInsets.all(max(size.width / 100, 10.0)),
          child: audiosController.currentAudio.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      "Audio: ${audiosController.currentAudio[0].id.toString()}",
                      style: const TextStyle(fontSize: textTitleSize),
                    ),
                    Text(
                      audiosController.currentAudio[0].audioUrl.toString(),
                      style:
                          const TextStyle(fontSize: textSize, color: colorGrey),
                    ),
                    Text(
                      audiosController.currentAudio[0].locale.toString(),
                      style:
                          const TextStyle(fontSize: textSize, color: colorGrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            width: 600,
                            child: Text(
                              audiosController.currentAudio[0].getText(),
                              maxLines: 10,
                              style: const TextStyle(fontSize: textSize),
                            ),
                          ),
                        ),
                        if (audiosController.currentAudio[0]
                            .getText()
                            .toString()
                            .isNotEmpty)
                          TextButton(
                            onPressed: () {
                              _controller.value = TextEditingValue(
                                  text: audiosController.currentAudio[0]
                                      .getText());
                            },
                            child: const Icon(Icons.edit),
                          ),
                      ],
                    ),
                    const Spacer(),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hints:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("1. Transribe all Errors as they are."),
                      ],
                    ),
                    const Spacer(),
                    if (audiosController.currentAudio.isNotEmpty)
                      AudioPlayer(audio: audiosController.currentAudio[0])
                    else
                      const AudioPlayer(audio: null),
                    Container(
                      color: Colors.grey[100],
                      child: TextFormField(
                        cursorColor: Colors.black,
                        maxLines: 5,
                        controller: _controller,
                        onChanged: (value) {
                          audiosController.currentAudio[0].transcribedText =
                              value;
                        },
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
                        OutlinedButton(
                            onPressed: () {
                              _nextAudio();
                            },
                            child: const Text("Skip")),
                        OutlinedButton(
                            onPressed: () {
                              audiosController.updateAudioTranscription(
                                  audiosController.currentAudio[0]);

                              // Next Audio
                              _nextAudio();
                            },
                            child: const Text("Save")),
                      ],
                    )
                  ],
                )
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Please choose an audio from the left side panel.",
                        style: TextStyle(fontSize: textSize, color: colorGrey),
                      ),
                      Text("(*_*)")
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
