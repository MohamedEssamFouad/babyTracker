import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BabyTrackerDatabase {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database?> initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'baby_tracker.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 4, onUpgrade: _onUpgrade);
    return mydb;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE baby (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      birthdate TEXT NOT NULL
    )
  ''');

    await db.execute('''
CREATE TABLE weight (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  baby_id INTEGER NOT NULL,
  weight REAL NOT NULL,
  name TEXT,  
  date TEXT NOT NULL,
  note TEXT,
  FOREIGN KEY (baby_id) REFERENCES baby(id) ON DELETE CASCADE
)
''');


    await db.execute('''
  CREATE TABLE height (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    baby_id INTEGER NOT NULL,
    name TEXT ,
    height REAL NOT NULL,
    date TEXT NOT NULL,
    note TEXT,  
    FOREIGN KEY (baby_id) REFERENCES baby(id) ON DELETE CASCADE
  )
''');


    await db.execute('''
    CREATE TABLE vaccine (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      baby_id INTEGER NOT NULL,
      name TEXT NOT NULL,
      date TEXT NOT NULL,
      note TEXT,
      FOREIGN KEY (baby_id) REFERENCES baby(id) ON DELETE CASCADE
    )
  ''');
    await db.execute('''
CREATE TABLE medicine (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  baby_id INTEGER NOT NULL,
  name TEXT NOT NULL,
  dose TEXT NOT NULL,
  date TEXT NOT NULL,
  note TEXT,
  FOREIGN KEY (baby_id) REFERENCES baby(id) ON DELETE CASCADE
)
''');


    await db.execute('''
    CREATE TABLE note (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      baby_id INTEGER NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      date TEXT NOT NULL,
      FOREIGN KEY (baby_id) REFERENCES baby(id) ON DELETE CASCADE
    )
  ''');



    print("Tables created.");
  }


  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    print("onUpgrade called");
  }



  deleteDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'baby_tracker.db');
    await deleteDatabase(path);
  }

  Future<int> insertVaccine(int babyId, String name, DateTime date, {String? note}) async {
    Database? mydb = await db;
    if (mydb != null) {
      int response = await mydb.insert(
        'vaccine_history',
        {'baby_id': babyId, 'name': name, 'date': date.toIso8601String(), 'note': note},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return response;
    } else {
      throw Exception("Database is null");
    }
  }
  Future<int> insertMedicine(int babyId, String name, String dose, DateTime date, {String? note}) async {
    Database? mydb = await db;

    if (mydb != null) {
      int response = await mydb.insert(
        'medicine',
        {
          'baby_id': babyId,
          'name': name,
          'dose': dose,
          'date': date.toIso8601String(),
          'note': note
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return response;
    } else {
      throw Exception("Database is null");
    }
  }
  Future<int> insertWeight(int babyId, double weight, DateTime date, {String? note}) async {
    Database? mydb = await db;
    if (mydb != null) {
      int response = await mydb.insert(
        'weight',
        {
          'baby_id': babyId,
          'weight': weight,

          'date': date.toIso8601String(),
          'note': note,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return response;
    } else {
      throw Exception("Database is null");
    }
  }



  Future<int> insertHeight(int babyId, double height, DateTime date, {String? note}) async {
    Database? mydb = await db;
    if (mydb != null) {
      int response = await mydb.insert(
        'height',
        {
          'baby_id': babyId,
          'height': height,
          'date': date.toIso8601String(),
          'note': note,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return response;
    } else {
      throw Exception("Database is null");
    }
  }


  Future<List<Map<String, dynamic>>> readDataForDate(String table, DateTime date) async {
    Database? mydb = await db;
    if (mydb != null) {
      String formattedDate = date.toIso8601String().substring(0, 10);
      List<Map<String, dynamic>> response = await mydb.query(
        table,
        where: "date LIKE ?",
        whereArgs: ['$formattedDate%'],
      );
      return response;
    } else {
      throw Exception("Database is null");
    }
  }

}