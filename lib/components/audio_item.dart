import 'package:flutter/material.dart';
import 'package:local_voice_desktop/utils/constants.dart';

class AudioItem extends StatefulWidget {
  const AudioItem({Key? key}) : super(key: key);

  @override
  _AudioItemState createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {
  Color backgroundColor = colorSidebar;

  void _hoverContainer(PointerEvent details) {
    setState(() {
      backgroundColor = colorSidebar.withAlpha(10);
    });
  }

  void _unHoverContainer(PointerEvent details) {
    setState(() {
      backgroundColor = colorSidebar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: _hoverContainer,
        onExit: _unHoverContainer,
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
          color: backgroundColor,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "387393",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "https://sdapi.ugspeechdata.com/asset/audo.mp3",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text("ak_gh"),
              Row(
                children: [
                  Container(
                      child: Text(
                    "UPLOADED",
                    style: TextStyle(fontSize: textSmall),
                  )),
                ],
              )
            ],
          ),
        ));
  }
}
