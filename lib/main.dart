import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_voice_desktop/dao/database.dart';
import 'package:local_voice_desktop/pages/home_page.dart';
import 'package:logger/logger.dart';
import 'package:media_kit/media_kit.dart';

Future<void> main() async {
  var rootToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);
  MediaKit.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  Logger(
    filter: null,
    printer: PrettyPrinter(),
    output: null,
  );
  runApp(const MyApp());
  initData();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Local Voice',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Local Voice'),
    );
  }
}
