import 'package:path/path.dart';
import 'package:question_answear_app/pages/admin/question/domain/question.dart';
import 'package:question_answear_app/pages/admin/section/domain/section.dart';
import 'package:sqflite/sqflite.dart';

import 'pages/admin/category/domain/category.dart';

class DatabaseHelper {
  //////////////////////////////
  static const _databaseName = "quiz1.db";
  static const _databaseVersion = 3;

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
            $progressSection TEXT NOT NULL,
            FOREIGN KEY ($categoryIdSection) REFERENCES categories(id) ON DELETE CASCADE
          )
              ''');

    await db.execute('''
    CREATE TABLE  $tableQuestions(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameQuestion TEXT NOT NULL,
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
            $isValidAnswer INTEGER NOT NULL,
            FOREIGN KEY ($questionIdAnswer) REFERENCES questions(id) ON DELETE CASCADE
          )
              ''');
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database? db = await instance.database;

    return await db!.insert(table, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.

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

  Future<List<Map<String, dynamic>>> queryAllWithRelation(int sectionId) async {
    Database db = await getDb();
    return await db.rawQuery(
        'SELECT questions.*,answers.* FROM work INNER JOIN questions ON questions.id = answers.questions_id where sections_id=$sectionId');
  }

  Future<List<Map<String, dynamic>>> joinss(String table) async {
    Database db = await getDb();
    return await db.rawQuery(
        'SELECT serviceproccess.id, serviceproccess.start, serviceproccess.end,clients.firstName as firstNameClient,clients.lastName as lastNameClient,services.name FROM serviceproccess INNER JOIN clients ON serviceproccess.idClient = clients.id INNER JOIN services ON serviceproccess.idService = services.id');
  }

  Future<List<Map<String, dynamic>>> getCurrentServiceProviderOfEmpl(
      String table, int idSerPro) async {
    Database db = await getDb();

    return await db.rawQuery(
        'SELECT  serviceproccess.id, serviceproccess.start, serviceproccess.end,clients.firstName as firstNameClient,clients.lastName as lastNameClient,services.name,services.price FROM serviceproccess INNER JOIN clients ON serviceproccess.idClient = clients.id INNER JOIN services ON serviceproccess.idService = services.id where serviceproccess.id=$idSerPro');
  }

  Future<List<Map<String, dynamic>>> getProccesingAssignEmpl(
      String table, int idEmp) async {
    Database db = await getDb();
    return await db.rawQuery(
        'SELECT DISTINCT serviceproccess.id, work.* FROM $table INNER JOIN serviceproccess ON serviceproccess.id = work.idserviceproccess where idEmployee=$idEmp');
  }

  Future<List<Map<String, dynamic>>> getServiceProData(int idEmp) async {
    Database db = await getDb();
    return await db.rawQuery(
        'SELECT work.*,serviceproccess.* FROM work INNER JOIN serviceproccess ON serviceproccess.id = work.idserviceproccess  where idEmployee=$idEmp');
  }

  Future<List<Map<String, dynamic>>> getPrices(int idService) async {
    Database db = await getDb();
    return await db.rawQuery('SELECT * FROM services where id=$idService');
  }

  Future<List<Map<String, dynamic>>> getAbsence(int idService) async {
    Database db = await getDb();
    return await db.rawQuery('SELECT *  FROM services where id=$idService');
  }

  // Future<int> updateClient(Clients client) async {
  //   Database db = await instance.database;
  //   int id = client.id;

  //   return await db
  //       .update("clients", client.toMap(), where: 'id = ?', whereArgs: [id]);
  // }

  // Future<int> updateEmpl(Employees emp) async {
  //   Database db = await instance.database;
  //   int id = emp.id;

  //   return await db
  //       .update("employees", emp.toMap(), where: 'id = ?', whereArgs: [id]);
  // }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, int id) async {
    Database db = (await instance.database)!;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
