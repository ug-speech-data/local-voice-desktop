import 'dart:io';

import 'package:local_voice_desktop/models/transcription_audio.dart';
import 'package:local_voice_desktop/utils/constants.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

var logger = Logger();

var transcriptionTable = "transcription_audios";
var dbName = "localvoice.sqlite3";

Database? db;
String? pathUri;
Future<Database> getDatabase() async {
  if (db == null || pathUri == null) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    pathUri = join((await getApplicationDocumentsDirectory()).path, dbName);
    File(pathUri!).create(recursive: true);

    logger.log(Level.info, "Opening DB @ $pathUri");
  }
  db = await databaseFactory.openDatabase(pathUri!);
  return db!;
}

Future<void> initData() async {
  final db = await getDatabase();
  logger.log(Level.info, "database created");

  await db.execute('''
  CREATE TABLE IF NOT EXISTS $transcriptionTable (
      id INTEGER PRIMARY KEY,
      name TEXT,
      audio_url TEXT,
      local_audio_url TEXT NULLABLE,
      text TEXT,
      transcribed_text TEXT,
      locale TEXT,
      duration INTEGER,
      task_type TEXT,
      audio_download_status TEXT,
      transcription_status TEXT
  )
  ''');
  logger.log(Level.info, "Audios table created.");
  db.close();
}

Future<void> insertAudioAll(List<TranscriptionAudio> audios) async {
  logger.log(Level.info, "Inserting ${audios.length} audios.");
  final db = await getDatabase();

  for (var index = 0; index < audios.length; index++) {
    TranscriptionAudio audio = audios[index];
    logger.log(
        Level.info, "Inserting ${index + 1} of ${audios.length} audios.");
    await db.insert(transcriptionTable, audio.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }
  db.close();
  logger.log(Level.info, "Insertion completed.");
}

Future<void> updateAudio(TranscriptionAudio audio) async {
  logger.log(Level.info, "Updating audio:  ${audio.toJson()}");

  // Get a reference to the database.
  final db = await getDatabase();

  await db.update(
    transcriptionTable,
    audio.toJson(),
    where: 'id = ?',
    whereArgs: [audio.id],
  );
}

// A method that retrieves all the dogs from the dogs table.
Future<List<TranscriptionAudio>> getAudios(String taskType) async {
  // // Get a reference to the database.
  final db = await getDatabase();

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query(
    transcriptionTable,
    where: "task_type=?",
    whereArgs: [taskType],
    orderBy: "audio_download_status ASC, transcription_status DESC, id ASC",
  );
  db.close();

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return TranscriptionAudio.fromJson(maps[i]);
  });
}

Future<List<TranscriptionAudio>> getDownloadPendingAudios() async {
  // Get a reference to the database.
  final db = await getDatabase();

  // Query the table for all the audios.
  final List<Map<String, dynamic>> maps = await db.query(
    transcriptionTable,
    orderBy: "transcription_status ASC",
    where: "audio_download_status=? OR audio_download_status=?",
    whereArgs: [
      AudioDownloadStatus.pending.value,
      AudioDownloadStatus.retry.value
    ],
  );
  db.close();

  // Convert the List<Map<String, dynamic> into a list.
  return List.generate(maps.length, (i) {
    return TranscriptionAudio.fromJson(maps[i]);
  });
}

Future<List<TranscriptionAudio>> getTranscribedAudios() async {
  // Get a reference to the database.
  final db = await getDatabase();

  // Query the table for all the audios.
  final List<Map<String, dynamic>> maps = await db.query(
    transcriptionTable,
    orderBy: "id ASC",
    where: "transcription_status=? AND task_type=?",
    whereArgs: [
      TranscriptionStatus.transcribed.value,
      TaskType.trancription.value
    ],
  );
  db.close();

  // Convert the List<Map<String, dynamic> into a list.
  return List.generate(maps.length, (i) {
    return TranscriptionAudio.fromJson(maps[i]);
  });
}

Future<List<TranscriptionAudio>> getResolutionTranscribedAudios() async {
  // Get a reference to the database.
  final db = await getDatabase();

  // Query the table for all the audios.
  final List<Map<String, dynamic>> maps = await db.query(
    transcriptionTable,
    orderBy: "id ASC",
    where: "transcription_status=? AND task_type=?",
    whereArgs: [
      TranscriptionStatus.transcribed.value,
      TaskType.resolution.value
    ],
  );
  db.close();

  // Convert the List<Map<String, dynamic> into a list.
  return List.generate(maps.length, (i) {
    return TranscriptionAudio.fromJson(maps[i]);
  });
}

Future<int> clearRedundantAudios(String taskType) async {
  // Get a reference to the database.
  final db = await getDatabase();
  var count = 0;

  // Query the table for all the audios.
  final List<Map<String, dynamic>> maps = await db.query(
    transcriptionTable,
    orderBy: "id ASC",
    where: "transcription_status != ? AND task_type=?",
    whereArgs: [TranscriptionStatus.transcribed.value, taskType],
  );

  // Convert the List<Map<String, dynamic> into a list.
  var audios = List.generate(maps.length, (i) {
    return TranscriptionAudio.fromJson(maps[i]);
  });

  for (var audio in audios) {
    if (audio.localAudioUrl != null) {
      var file = File(audio.localAudioUrl!);
      if (await file.exists()) {
        file.delete(recursive: true);
        count++;
      }
    }
  }

  // DB Deletion
  await db.delete(
    transcriptionTable,
    where: "transcription_status != ?",
    whereArgs: [TranscriptionStatus.transcribed.value],
  );
  db.close();
  return count;
}
