import 'package:path/path.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:sqflite/sqflite.dart';

import 'pages/admin/category/domain/category.dart';

class DatabaseHelper {
  //////////////////////////////
  static const _databaseName = "quiz6.db";
  static const _databaseVersion = 1;

  static const String id = "id";

  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
    await Sqflite.devSetDebugModeOn(true);

    if (_database != null) return _database;

    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < _databaseVersion) {
        _onCreate;
      }
    }, onConfigure: _onConfigure);
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE  $tableCategories(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameCategory TEXT NOT NULL
                  )
     
    ''');

    await db.execute('''
    CREATE TABLE  $tableSections(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameSection TEXT NOT NULL,
            $categoryIdSection INTEGER NOT NULL,
            $indexLastQuestionSection INTEGER NOT NULL,
            $progressSection TEXT NOT NULL,
            FOREIGN KEY ($categoryIdSection) REFERENCES categories(id) ON DELETE CASCADE
          )
              ''');

    await db.execute('''
    CREATE TABLE  $tableQuestions(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameQuestion TEXT NOT NULL,
            $photoQuestion TEXT NULL,
            $sectionIdQuestion INTEGER NOT NULL,
            $answeredQuestion INTEGER NOT NULL,
           FOREIGN KEY ($sectionIdQuestion) REFERENCES sections(id) ON DELETE CASCADE
          )
              ''');

    await db.execute('''
    CREATE TABLE  $tableAnswers(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameAnswer TEXT NOT NULL,
            $questionIdAnswer INTEGER NOT NULL,
            $photoQuestion TEXT NULL,
            $isValidAnswer INTEGER NOT NULL,
            FOREIGN KEY ($questionIdAnswer) REFERENCES questions(id) ON DELETE CASCADE
          )
              ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database? db = await instance.database;

    return await db!.insert(table, row);
  }

  Future<Database> getDb() async {
    return (await instance.database)!;
  }

  Future<List<Map<String, dynamic>>> queryData(String table,
      {String? where, List? argsWhere}) async {
    Database db = await getDb();
    return await db.query(
      table,
      where: where,
      whereArgs: argsWhere,
      orderBy: "id Desc",
    );
  }

  Future<List<Map<String, dynamic>>> queryCategoriesWithCountSection() async {
    Database db = await getDb();
    return await db.rawQuery(
        'SELECT T1.*,count(T2.categories_id) as section_count FROM categories as T1 LEFT OUTER JOIN sections as T2 ON T1.id = T2.categories_id GROUP BY T2.categories_id');
  }

  Future<List<Map<String, dynamic>>> querySectionsWithCountQuestion(
      int categoryId) async {
    Database db = await getDb();
    return await db.rawQuery(
        'SELECT S.*,count(Q.sections_id) as question_count FROM sections as S LEFT OUTER JOIN questions as Q ON S.id = Q.sections_id where S.categories_id=$categoryId GROUP BY Q.sections_id');
  }

  Future<int> update(
      String table, Map<String, dynamic> map, List? argsWhere) async {
    Database db = await getDb();

    return await db.update(table, map, where: 'id = ?', whereArgs: argsWhere);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, int id) async {
    Database db = (await instance.database)!;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
