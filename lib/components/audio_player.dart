import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:local_voice_desktop/models/transcription_audio.dart';
import 'package:just_audio/just_audio.dart' as lib_player;

class AudioPlayer extends StatelessWidget {
  AudioPlayer({Key? key, required this.audio}) : super(key: key);
  final TranscriptionAudio? audio;
  final player = lib_player.AudioPlayer();

  Future<void> initPlayer() async {
    final duration = await player.setUrl(audio!.audioUrl);
    player.play();
    await player.play();
  }

  @override
  Widget build(BuildContext context) {
    initPlayer();

    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Icon(Icons.play_arrow_outlined),
          ),
        ),
        Slider(value: 0.3, onChanged: (value) {}),
        Text("00:33"),
      ],
    );
  }
}
