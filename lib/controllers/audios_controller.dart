import 'package:dio/dio.dart' as dio_lib;
import 'package:get/get.dart';
import 'package:local_voice_desktop/models/transcription_audio.dart';
import 'package:local_voice_desktop/services/remote_services.dart';

class AudiosController extends GetxController {
  RxList audios = [].obs;
  RxList currentAudio = [].obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;

  Future<List<TranscriptionAudio>?> getAudiosToTranscribe() async {
    try {
      isLoading(true);
      dio_lib.Response response = await RemoteServices.getAudiosToTranscribe();
      if (response.statusCode == 200) {
        List<TranscriptionAudio> value =
            transcriptionAudioFromJson(response.toString());
        audios.value = value;
        return value;
      } else {
        errorMessage.value = "Error: ${response.statusMessage}";
      }
    } on Exception catch (e) {
      errorMessage.value = "Error: $e";
    } finally {
      isLoading(false);
    }
    return null;
  }
}
