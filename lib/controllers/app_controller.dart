import 'package:get/get.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class AppController extends GetxController {
  var isLoading = true.obs;
  RxString taskType = TaskType.resolution.value.obs;
}
