// To parse this JSON data, do
//
//     final transcriptionAudio = transcriptionAudioFromJson(jsonString);

import 'dart:convert';

import 'package:local_voice_desktop/utils/constants.dart';

List<TranscriptionAudio> transcriptionAudioFromJson(String str) =>
    List<TranscriptionAudio>.from(
        json.decode(str)["audios"].map((x) => TranscriptionAudio.fromJson(x)));

String transcriptionAudioToJson(List<TranscriptionAudio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TranscriptionAudio {
  final int id;
  final String name;
  final String audioUrl;
  String? localAudioUrl;
  final String text;
  String transcribedText;
  final String locale;
  final int duration;
  final String taskType;
  String audioDownloadStatus;
  String transcriptionStatus;

  TranscriptionAudio({
    required this.id,
    required this.name,
    required this.audioUrl,
    required this.localAudioUrl,
    required this.text,
    required this.transcribedText,
    required this.locale,
    required this.duration,
    required this.audioDownloadStatus,
    required this.taskType,
    required this.transcriptionStatus,
  });

  String getText() {
    if (transcribedText.isEmpty) {
      return text;
    }
    return transcribedText;
  }

  String getPlayableUrl() {
    if (localAudioUrl?.isNotEmpty == true) {
      return localAudioUrl!;
    }
    return audioUrl;
  }

  factory TranscriptionAudio.fromJson(Map<String, dynamic> json) =>
      TranscriptionAudio(
          id: json["id"],
          name: json["name"],
          audioUrl: json["audio_url"],
          localAudioUrl: null,
          text: json["text"],
          transcribedText: json["transcribed_text"] ?? "",
          locale: json["locale"],
          duration: json["duration"],
          taskType: json["task_type"] ?? TaskType.trancription.value,
          audioDownloadStatus: json["audio_download_status"] ??
              AudioDownloadStatus.pending.value,
          transcriptionStatus:
              json["transcription_status"] ?? TranscriptionStatus.nnew.value);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "audio_url": audioUrl,
        "local_audio_url": localAudioUrl,
        "text": text,
        "transcribed_text": transcribedText,
        "locale": locale,
        "duration": duration,
        "task_type": taskType,
        "audio_download_status": audioDownloadStatus,
        "transcription_status": transcriptionStatus,
      };
}
