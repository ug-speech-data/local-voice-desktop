// To parse this JSON data, do
//
//     final transcriptionAudio = transcriptionAudioFromJson(jsonString);

import 'dart:convert';

List<TranscriptionAudio> transcriptionAudioFromJson(String str) =>
    List<TranscriptionAudio>.from(
        json.decode(str)["audios"].map((x) => TranscriptionAudio.fromJson(x)));

String transcriptionAudioToJson(List<TranscriptionAudio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TranscriptionAudio {
  int id;
  String imageUrl;
  List<Validation> validations;
  String thumbnail;
  String name;
  String submittedBy;
  String emailAddress;
  String audioUrl;
  int imageBatchNumber;
  DateTime createdAt;
  String participantPhone;
  String text;
  String file;
  String mainFileFormat;
  dynamic fileMp3;
  String deviceId;
  int validationCount;
  int transcriptionCount;
  int year;
  String locale;
  String apiClient;
  int duration;
  String environment;
  bool isAccepted;
  bool rejected;
  bool deleted;
  String audioStatus;
  String transcriptionStatus;
  DateTime updatedAt;
  bool checkedInForTranscription;
  dynamic note;
  String secondAudioStatus;
  int image;
  int participant;
  dynamic conflictResolvedBy;

  TranscriptionAudio({
    required this.id,
    required this.imageUrl,
    required this.validations,
    required this.thumbnail,
    required this.name,
    required this.submittedBy,
    required this.emailAddress,
    required this.audioUrl,
    required this.imageBatchNumber,
    required this.createdAt,
    required this.participantPhone,
    required this.text,
    required this.file,
    required this.mainFileFormat,
    required this.fileMp3,
    required this.deviceId,
    required this.validationCount,
    required this.transcriptionCount,
    required this.year,
    required this.locale,
    required this.apiClient,
    required this.duration,
    required this.environment,
    required this.isAccepted,
    required this.rejected,
    required this.deleted,
    required this.audioStatus,
    required this.transcriptionStatus,
    required this.updatedAt,
    required this.checkedInForTranscription,
    required this.note,
    required this.secondAudioStatus,
    required this.image,
    required this.participant,
    required this.conflictResolvedBy,
  });

  factory TranscriptionAudio.fromJson(Map<String, dynamic> json) =>
      TranscriptionAudio(
        id: json["id"],
        imageUrl: json["image_url"],
        validations: List<Validation>.from(
            json["validations"].map((x) => Validation.fromJson(x))),
        thumbnail: json["thumbnail"],
        name: json["name"],
        submittedBy: json["submitted_by"],
        emailAddress: json["email_address"],
        audioUrl: json["audio_url"],
        imageBatchNumber: json["image_batch_number"],
        createdAt: DateTime.parse(json["created_at"]),
        participantPhone: json["participant_phone"],
        text: json["text"],
        file: json["file"],
        mainFileFormat: json["main_file_format"],
        fileMp3: json["file_mp3"],
        deviceId: json["device_id"],
        validationCount: json["validation_count"],
        transcriptionCount: json["transcription_count"],
        year: json["year"],
        locale: json["locale"],
        apiClient: json["api_client"],
        duration: json["duration"],
        environment: json["environment"],
        isAccepted: json["is_accepted"],
        rejected: json["rejected"],
        deleted: json["deleted"],
        audioStatus: json["audio_status"],
        transcriptionStatus: json["transcription_status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        checkedInForTranscription: json["checked_in_for_transcription"],
        note: json["note"],
        secondAudioStatus: json["second_audio_status"],
        image: json["image"],
        participant: json["participant"],
        conflictResolvedBy: json["conflict_resolved_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "validations": List<dynamic>.from(validations.map((x) => x.toJson())),
        "thumbnail": thumbnail,
        "name": name,
        "submitted_by": submittedBy,
        "email_address": emailAddress,
        "audio_url": audioUrl,
        "image_batch_number": imageBatchNumber,
        "created_at": createdAt.toIso8601String(),
        "participant_phone": participantPhone,
        "text": text,
        "file": file,
        "main_file_format": mainFileFormat,
        "file_mp3": fileMp3,
        "device_id": deviceId,
        "validation_count": validationCount,
        "transcription_count": transcriptionCount,
        "year": year,
        "locale": locale,
        "api_client": apiClient,
        "duration": duration,
        "environment": environment,
        "is_accepted": isAccepted,
        "rejected": rejected,
        "deleted": deleted,
        "audio_status": audioStatus,
        "transcription_status": transcriptionStatus,
        "updated_at": updatedAt.toIso8601String(),
        "checked_in_for_transcription": checkedInForTranscription,
        "note": note,
        "second_audio_status": secondAudioStatus,
        "image": image,
        "participant": participant,
        "conflict_resolved_by": conflictResolvedBy,
      };
}

class Validation {
  String user;
  bool isValid;

  Validation({
    required this.user,
    required this.isValid,
  });

  factory Validation.fromJson(Map<String, dynamic> json) => Validation(
        user: json["user"],
        isValid: json["is_valid"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "is_valid": isValid,
      };
}
