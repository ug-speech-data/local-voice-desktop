import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/components/audio_item.dart';
import 'package:local_voice_desktop/controllers/audios_controller.dart';
import 'package:local_voice_desktop/utils/constants.dart';
import 'package:getwidget/getwidget.dart';

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
              child: Row(
                children: [
                  Obx(() => Padding(
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
                      )),
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
                      onPressed: () {},
                      child: const Icon(Icons.refresh_outlined),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {}, child: const Icon(Icons.sort_outlined))
            ],
          ),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...audiosController.audios
                          .map((audio) => AudioItem(audio: audio))
                    ],
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
