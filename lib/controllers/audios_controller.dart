import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart' as dio_lib;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/dao/database.dart';
import 'package:local_voice_desktop/models/transcription_audio.dart';
import 'package:local_voice_desktop/services/remote_services.dart';
import 'package:local_voice_desktop/utils/constants.dart';
import 'package:local_voice_desktop/utils/file_downloader.dart';
import 'package:logger/logger.dart';

var logger = Logger();
RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

class AudiosController extends GetxController {
  RxList audios = [].obs;
  RxList currentAudio = [].obs;
  var isLoading = false.obs;
  var isRefreshingFromDb = false.obs;
  var errorMessage = "".obs;

  @override
  void onInit() async {
    await refreshAudiosFromDb();
    checkUpdateUndownloadedAudios();
    super.onInit();
  }

  Future<void> refreshAudiosFromDb() async {
    isRefreshingFromDb(true);
    var auds = await getAudios();
    isRefreshingFromDb(false);
    audios.value = auds;

    // Try downloading pending mp3 files.
    checkUpdateUndownloadedAudios();

    logger.log(Level.info, "Found ${auds.length} audios in db.");
  }

  Future<List<TranscriptionAudio>?> getAudiosToTranscribe() async {
    logger.log(Level.info, "Getting transcription audios");

    try {
      isLoading(true);
      errorMessage.value = "";
      dio_lib.Response response = await RemoteServices.getAudiosToTranscribe();
      if (response.statusCode == 200) {
        List<TranscriptionAudio> values =
            transcriptionAudioFromJson(response.toString());
        audios.value = values;

        // Insert audio into db.
        await insertAudioAll(values);
        checkUpdateUndownloadedAudios();
        return values;
      } else {
        errorMessage.value = "Error: ${response.statusMessage}";
        logger.log(Level.error, "Error: ${response.statusMessage}");
      }
    } on Exception catch (e) {
      errorMessage.value = "Error: $e";
      logger.log(Level.error, "Error: $e");
    } finally {
      isLoading(false);
    }
    return null;
  }

  Future<void> updateAudioTranscription(TranscriptionAudio audio) async {
    audio.transcriptionStatus = TranscriptionStatus.transcribed.value;
    await updateAudio(audio);
    await refreshAudiosFromDb();
  }

  void checkUpdateUndownloadedAudios() {
    void _checkUpdateUndownloadedAudios(void _) {
      getDownloadPendingAudios().then((audios) {
        for (TranscriptionAudio audio in audios) {
          downloadFile(audio.audioUrl).then((path) {
            if (path != null) {
              audio.audioDownloadStatus = AudioDownloadStatus.downloaded.value;
              audio.localAudioUrl = path;
            } else {
              String newStatus =
                  audio.audioDownloadStatus == AudioDownloadStatus.retry.value
                      ? AudioDownloadStatus.failed.value
                      : AudioDownloadStatus.retry.value;
              audio.audioDownloadStatus = newStatus;
            }
            updateAudio(audio);
          });
        }
      });
    }

    _checkUpdateUndownloadedAudios(null);
  }

  static void _uploadTranscribedAudios() {
    // Send result back to the main UI isolate
    getTranscribedAudios().then((audios) {
      for (TranscriptionAudio audio in audios) {
        RemoteServices.uploadTranscription(audio).then((response) async {
          if (response.statusCode == 200) {
            audio.transcriptionStatus = TranscriptionStatus.uploaded.value;
            await updateAudio(audio);
          }
        });
      }
    });
  }

  Future<void> uploadTranscribedAudios() async {
    _uploadTranscribedAudios();
  }

  Future<void> clearAudios() async {
    await clearRedundantAudios();
    refreshAudiosFromDb();
  }
}
