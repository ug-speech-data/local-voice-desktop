import 'package:flutter/material.dart';
import 'package:local_voice_desktop/components/page_content.dart';
import 'package:local_voice_desktop/components/side_bar_menu.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
    required String title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SideBarMenu(),
        Expanded(
          child: PageContent(),
        ),
      ],
    );
  }
}
