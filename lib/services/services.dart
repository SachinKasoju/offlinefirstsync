import 'package:hive_flutter/hive_flutter.dart';

class HiveDBService {

  static late Box notesBox;
  static late Box queueBox;

  static Future init() async {

    await Hive.initFlutter();

    notesBox = await Hive.openBox("notes");
    queueBox = await Hive.openBox("sync_queue");

  }

}