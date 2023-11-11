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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.infinity,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              audiosController.currentAudio.value = [audio];
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audio.id.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  audio.audioUrl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: audio.audioDownloadStatus.toUpperCase() ==
                            AudioDownloadStatus.downloaded.value
                        ? colorSuccess.withGreen(130).withBlue(100)
                        : colorError.withBlue(250),
                  ),
                ),
                Text(audio.locale),
                Text(
                  audio.getText(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 10, color: colorMain),
                ),
                Row(
                  children: [
                    Text(
                      "${audio.audioDownloadStatus.toUpperCase()} | ${audio.transcriptionStatus.toUpperCase()}",
                      style: const TextStyle(fontSize: textSmall),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
