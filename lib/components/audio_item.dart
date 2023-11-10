import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/controllers/audios_controller.dart';
import 'package:local_voice_desktop/models/transcription_audio.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class AudioItem extends StatelessWidget {
  AudioItem({Key? key, required this.audio}) : super(key: key);
  final TranscriptionAudio audio;

  final AudiosController audiosController = Get.put(AudiosController());

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        width: double.infinity,
        child: Material(
          child: InkWell(
            onTap: () {
              audiosController.currentAudio.value = [audio];
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audio.id.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  audio.audioUrl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(audio.locale),
                const Row(
                  children: [
                    Text(
                      "UPLOADED",
                      style: TextStyle(fontSize: textSmall),
                    ),
                  ],
                )
              ],
            ),
          ),
          color: Colors.transparent,
        ));
  }
}
