import 'package:flutter/material.dart';
import 'package:local_voice_desktop/models/transcription_audio.dart';
import 'package:media_kit/media_kit.dart';

class AudioPlayer extends StatefulWidget {
  const AudioPlayer({Key? key, required this.audio}) : super(key: key);
  final TranscriptionAudio? audio;

  @override
  State<StatefulWidget> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  final player = Player();
  bool isPlaying = false;
  bool fullyPlayed = false;
  Duration playerDuration = const Duration(seconds: 0);
  double durationInSeconds = 0.001; // Zero might result in division by 0 error.

  Future<void> _playOrPause() async {
    await player.playOrPause();
  }

  void _seekAudio(value) {
    if (fullyPlayed) {
      player.seek(Duration(seconds: (durationInSeconds * value).toInt()));
    }
  }

  @override
  void initState() {
    super.initState();
    final playable = Media(widget.audio!.getPlayableUrl());
    player.open(playable, play: false);
  }

  @override
  void didUpdateWidget(AudioPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    final playable = Media(widget.audio!.getPlayableUrl());
    player.open(playable, play: false);
    setState(() {
      fullyPlayed = false;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    player.stream.position.listen(
      (Duration position) {
        setState(() {
          playerDuration = position;
          if (!fullyPlayed) {
            fullyPlayed = position.inSeconds > 0 &&
                position.inSeconds == durationInSeconds.toInt();
          }
        });
      },
    );

    player.stream.playing.listen(
      (bool playing) {
        setState(() {
          isPlaying = playing;
        });
      },
    );
    player.stream.duration.listen(
      (Duration duration) {
        setState(() {
          var value = duration.inSeconds.toDouble();
          if (!value.isNaN) {
            durationInSeconds = value;
          }
        });
      },
    );

    return Row(
      children: [
        InkWell(
          onTap: _playOrPause,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
                isPlaying ? Icons.pause_outlined : Icons.play_arrow_outlined),
          ),
        ),
        Slider(
            value: (playerDuration.inSeconds / durationInSeconds).isNaN == false
                ? playerDuration.inSeconds / durationInSeconds
                : 0.0,
            onChanged: fullyPlayed
                ? (value) {
                    _seekAudio(value);
                  }
                : null),
        Text(
            "00:${playerDuration.inSeconds.toString().padLeft(2, "0")}/00:${durationInSeconds.toInt().toString().padLeft(2, "0")}"),
      ],
    );
  }
}
