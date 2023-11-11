import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/components/audio_item.dart';
import 'package:local_voice_desktop/controllers/audios_controller.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class SideBarMenu extends StatelessWidget {
  SideBarMenu({
    super.key,
  });

  final AudiosController audiosController = Get.put(AudiosController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final maxSidebarWidth = min(300.0, size.width * 0.2);

    return SizedBox(
      width: max(maxSidebarWidth, 250),
      height: size.height - navHeight,
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(
                () => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: OutlinedButton(
                        onPressed: !audiosController.isLoading.value
                            ? () {
                                audiosController
                                    .getAudiosToTranscribe()
                                    .then((value) {});
                              }
                            : null,
                        child: Row(
                          children: [
                            const Icon(Icons.download_for_offline),
                            audiosController.isLoading.value
                                ? const Text("Requesting...")
                                : const Text("Download")
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Icon(Icons.upload_file_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: OutlinedButton(
                        onPressed: !audiosController.isRefreshingFromDb.value
                            ? () {
                                audiosController.refreshAudiosFromDb();
                              }
                            : null,
                        child: Row(
                          children: [
                            audiosController.isRefreshingFromDb.value
                                ? const Text("Refreshing...")
                                : const Text("Refresh"),
                            const Icon(Icons.refresh_outlined)
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Icon(Icons.delete_forever_outlined),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${audiosController.audios.length} items retrieved.",
                    style: const TextStyle(color: colorGrey),
                  ),
                  TextButton(
                      onPressed: () {}, child: const Icon(Icons.sort_outlined))
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey[100],
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(
                  () => audiosController.audios.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...audiosController.audios.map((audio) => Container(
                                color: audiosController
                                            .currentAudio.isNotEmpty &&
                                        audiosController.currentAudio[0].id ==
                                            audio.id
                                    ? colorMain.withAlpha(50)
                                    : null,
                                child: AudioItem(audio: audio)))
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 5),
                          child: Center(
                            child: Column(
                              children: [
                                if (audiosController.errorMessage.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      audiosController.errorMessage
                                          .toLowerCase(),
                                      style: const TextStyle(
                                          fontSize: 10, color: colorError),
                                    ),
                                  ),
                                const Text(
                                  "Nothing is here...Download new audios.",
                                  style: TextStyle(color: colorGrey),
                                )
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
