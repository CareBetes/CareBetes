import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'carebetes'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, version) async {
    await db.execute(_user);
    await db.execute(_medicationCalendar);
    await db.execute(_medicationAppointmentCalendar);
  }

  String get _user => '''
    CREATE TABLE user (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      type_betes TEXT,
      age INTEGER,
      weight REAL,
      email TEXT,
      password TEXT
    );
  ''';

  String get _medicationAppointmentCalendar => '''
    CREATE TABLE medication_appointment_calendar (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      title TEXT,
      date TEXT,
      timer TEXT,
      remember_date_at TEXT,
      remember_timer_at TEXT,
      remember TEXT
    );
  ''';

  String get _medicationCalendar => '''
    CREATE TABLE medication_calendar (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER,
      title TEXT,
      timer TEXT,
      repeat_at TEXT,
      remember TEXT
    );
  ''';
}
