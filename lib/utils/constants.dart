import 'package:flutter/material.dart';

const colorMain = Colors.teal;
const colorSidebar = Color.fromARGB(255, 250, 250, 250);
const colorMainComplement = Color(0xfff58300);
const colorMainLight = Color(0xff298dff);
const colorError = Color.fromRGBO(245, 0, 0, 1);
const colorGrey = Color.fromRGBO(150, 150, 150, 1);
const colorSuccess = Color(0xff02ddac);

// const String BASE_URL = "http://localhost:8000/api";
const String BASE_URL = "https://sdapi2.ugspeechdata.com/api";

const navHeight = 50.0;
const textTitleSize = 25.0;
const textSize = 18.0;
const textSmall = 10.0;

enum TranscriptionStatus { nnew, transcribed, uploaded }

enum AudioDownloadStatus { pending, downloaded, retry, failed }

extension TranscriptionStatusExtension on TranscriptionStatus {
  String get value {
    switch (this) {
      case TranscriptionStatus.nnew:
        return "NEW";
      case TranscriptionStatus.transcribed:
        return "TRANSCRIBED";
      case TranscriptionStatus.uploaded:
        return "UPLOADED";
    }
  }
}

extension AudioDownloadStatusExtension on AudioDownloadStatus {
  String get value {
    switch (this) {
      case AudioDownloadStatus.pending:
        return "NEW";
      case AudioDownloadStatus.downloaded:
        return "DOWNLOADED";
      case AudioDownloadStatus.retry:
        return "RETRY";
      case AudioDownloadStatus.failed:
        return "FAILED";
    }
  }
}
