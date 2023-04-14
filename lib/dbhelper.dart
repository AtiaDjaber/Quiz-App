import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'pages/category/domain/category.dart';

class DatabaseHelper {
  //////////////////////////////
  static const _databaseName = "manages.db";
  static const _databaseVersion = 1;

  static const services = 'services';

  static const String columnIdS = "id";
  static const String columnNameS = "name";
  static const String columnPriceS = "price";
  static const String columnTypeS = "type";

  static const String id = "id";

  static const clients = 'clients';

  DatabaseHelper._internal();

  static final DatabaseHelper instance = DatabaseHelper._internal();

  static Database? _database;

  Future<Database?> get database async {
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
    CREATE TABLE  $services(
            $id INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnNameS TEXT NOT NULL,
            $columnPriceS TEXT NOT NULL,
            $columnTypeS TEXT NOT NULL
          )
              ''');
    createTable(db);
    // await db.execute('''
    // CREATE TABLE  $servicesProccess(
    //         $id INTEGER PRIMARY KEY AUTOINCREMENT,
    //         $startDateSI TEXT NOT NULL,
    //         $endDateSI TEXT NOT NULL,
    //         $columnClientId integer,
    //         $columnEmplId integer,
    //        "$columnServiceId integer,
    //        "FOREIGN KEY (idService) REFERENCES services (id) ON DELETE NO ACTION,"
    //        "FOREIGN KEY (idClient) REFERENCES clients (id) ON DELETE NO ACTION,"
    //        "FOREIGN KEY (idEmplyee) REFERENCES employees (id) ON DELETE NO ACTION"
    //       )
    //           ''');
  }

  createTable(Database db) async {
    await db.execute("""
            CREATE TABLE serviceproccess (
              id INTEGER PRIMARY KEY, 
              idEmplyee INTEGER,
              idClient INTEGER,
              idService INTEGER,
              start TEXT NOT NULL,
              end TEXT NOT NULL,
              FOREIGN KEY (idClient) REFERENCES clients (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION,
              FOREIGN KEY (idService) REFERENCES services (id) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
          )""");
    // ,
    //     FOREIGN KEY (idEmplyee) REFERENCES employees (id)
    //       ON DELETE NO ACTION ON UPDATE NO ACTION
    await db.execute("""
            CREATE TABLE work (
              idServiceProccess INTEGER NOT NULL,
              idEmployee INTEGER NOT NULL,
              workDuration TEXT,
              workDate TEXT,
              FOREIGN KEY (idServiceProccess) REFERENCES serviceproccess (id) 
                ON DELETE NO ACTION ,
              FOREIGN KEY (idEmployee) REFERENCES employees (id) 
                ON DELETE NO ACTION 
            )""");

    await db.execute("""
            CREATE TABLE absence (
              id INTEGER PRIMARY KEY, 
              idEmployee INTEGER NOT NULL,
              dateAbsence TEXT,
              absenceDuration TEXT,
              FOREIGN KEY (idEmployee) REFERENCES employees (id) 
                ON DELETE NO ACTION 
            )""");
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database? db = await instance.database;

    return await db!.insert(table, row);
  }

  // Future<int> insertClients(String table, Map<String, dynamic> row) async {
  //   Database db = await instance.database;
  //   return await db.insert(table, row);
  // }

  // Future<void> insertServices(Services service) async {
  //   Database db = await instance.database;
  //   return await db
  //       .insert(services, {'name': service.name, 'price': service.price});
  // }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.

  Future<Database> getDb() async {
    return (await instance.database)!;
  }

  Future<List<Map<String, dynamic>>> queryData(String table) async {
    Database db = await getDb();
    return await db.query(
      table,
      orderBy: "id Desc",
    );
  }

  Future<List<Map<String, dynamic>>> queryAllServEmp(
      String table, int idServPro) async {
    Database db = await getDb();
    return await db.rawQuery(
        'SELECT employees.* FROM work INNER JOIN employees ON employees.id = work.idEmployee where idServiceProccess=$idServPro');
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

// ,employees.firstName as firstNameEmp,employees.lastName as lastNameEmp,
  Future<List<Map<String, dynamic>>> queryAllRowsService() async {
    Database db = await getDb();
    return await db.query(services);
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

  Future<int> updateService(Category category) async {
    Database db = await getDb();
    int id = category.id!;

    return await db
        .update("services", category.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(String table, int id) async {
    Database db = (await instance.database)!;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteServices(int id) async {
    Database db = await getDb();
    await db.delete(services, where: 'id = ?', whereArgs: [id]);
  }
}
