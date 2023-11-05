import 'dart:math';

import 'package:flutter/material.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class PageContent extends StatelessWidget {
  const PageContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height - navHeight,
      child: Padding(
        padding: EdgeInsets.all(max(size.width / 100, 10.0)),
        child: Column(
          children: [
            const Text(
              "Audio 1",
              style: TextStyle(fontSize: textTitleSize),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Audio transcriptions",
                  maxLines: 10,
                  style: TextStyle(fontSize: textSize),
                ),
                TextButton(
                  onPressed: () {},
                  child: Icon(Icons.edit),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hints:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("1. Use the Ctrl Key on the keyboard to play/pause."),
                Text("2. Transribe all Errors as they are."),
              ],
            ),
            const Spacer(),
            Row(
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
            ),
            Container(
              color: Colors.grey[100],
              child: TextFormField(
                cursorColor: Colors.black,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      // borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    hintText: "Trascription goes here."),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(onPressed: () {}, child: Text("Skip")),
                OutlinedButton(onPressed: () {}, child: Text("Save")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
