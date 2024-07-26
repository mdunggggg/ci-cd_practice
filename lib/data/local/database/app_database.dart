import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:flutter_clean_architecture/data/model/person_model.dart';

import '../dao/person_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [PersonModel])
abstract class AppDatabase extends FloorDatabase {
  static AppDatabase? _instance;
  static AppDatabase get instance {
    return _instance!;
  }

  PersonDao get personDao;
  static Future<void> init() async {
    _instance = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }
}
