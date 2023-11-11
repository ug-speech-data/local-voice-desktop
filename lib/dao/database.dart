import 'package:local_voice_desktop/models/transcription_audio.dart';
import 'package:local_voice_desktop/utils/constants.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

var logger = Logger();

var transcriptionTable = "transcription_audios";
var dbName = "localvoicev.sqlite3";

Database? db;
String? pathUri;
Future<Database> getDatabase() async {
  if (db == null || pathUri == null) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    pathUri = join(await getDatabasesPath(), dbName);
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

  audios.asMap().forEach((index, audio) async {
    logger.log(Level.info, "Inserting $index of ${audios.length} audios.");
    await db.insert(transcriptionTable, audio.toJson(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  });
  logger.log(Level.info, "Insertion completed.");
  db.close();
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
  db.close();
}

// A method that retrieves all the dogs from the dogs table.
Future<List<TranscriptionAudio>> getAudios() async {
  // // Get a reference to the database.
  final db = await getDatabase();

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query(
    transcriptionTable,
    orderBy: "transcription_status ASC, id ASC",
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
    where: "transcription_status=?",
    whereArgs: [TranscriptionStatus.transcribed.value],
  );
  db.close();

  // Convert the List<Map<String, dynamic> into a list.
  return List.generate(maps.length, (i) {
    return TranscriptionAudio.fromJson(maps[i]);
  });
}
