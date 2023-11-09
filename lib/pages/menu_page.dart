import 'package:flutter/material.dart';
import 'package:local_voice_desktop/components/app_nav_bar.dart';
import 'package:local_voice_desktop/components/main_page.dart';
import 'package:local_voice_desktop/pages/home_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // App Bar
          AppNavBar(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: ""),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("Transcription"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: ""),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text("Transcription Resolution"),
            ),
          ),
          // Main page
        ],
      ),
    );
  }
}
