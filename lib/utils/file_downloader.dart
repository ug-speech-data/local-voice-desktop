import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

var logger = Logger();

Future<String?> downloadFile(String url) async {
  logger.log(Level.info, "Downloading $url");
  String dir = Directory.current.path;
  var filenames = url.split("/");
  var filename = filenames[filenames.length - 1];
  File file = File(
      '$dir${Platform.pathSeparator}.audios${Platform.pathSeparator}$filename');

  if (await file.parent.exists() == false) {
    file.parent.create(recursive: true);
  }

  http.Response response;
  try {
    response = await http.get(Uri.parse((url)));
  } on Exception catch (_) {
    return null;
  }

  if (response.statusCode == 200) {
    var bytes = response.bodyBytes;
    await file.writeAsBytes(bytes);
    return file.path;
  }
  return null;
}
