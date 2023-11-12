import 'package:flutter/material.dart';
import 'package:local_voice_desktop/components/app_nav_bar.dart';
import 'package:local_voice_desktop/components/main_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
          const MainPage(
            title: '',
          )
          // Main page
        ],
      ),
    );
  }
}
