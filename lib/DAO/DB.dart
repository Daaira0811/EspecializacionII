import 'dart:io';
import 'package:flutter_application_fincet/models/Cuenta.dart';
import 'package:flutter_application_fincet/models/Dinero.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DB {

  static final _databaseName = "fincet.db";
  static final _databaseVersion = 1;

  DB._privateConstructor();

  static final DB instance = DB._privateConstructor();

  static Database? _database;

    Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDB();
    return _database;
  }

   static _initDB() async {
    Directory documentsDirectory = await
    getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, _databaseName);
    
    return await openDatabase(path,
      version:_databaseVersion,
      onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    // SQL code to create Cuenta table
    await db.execute('''  
        CREATE TABLE cuenta (
          id INTEGER PRIMARY KEY ,
          nombreCuenta TEXT NOT NULL UNIQUE,
          saldo INTEGER,
          moneda TEXT NOT NULL,
          color TEXT NOT NULL
         )''');
    // SQL code to create Gasto table
    await db.execute('''  
        CREATE TABLE dinero (
          id INTEGER PRIMARY KEY ,
          idCuenta INTEGER ,    
          monto INTEGER,
          asunto TEXT NOT NULL,
          fechaHora TEXT,
          tipoOperacion TEXT,    
          FOREIGN KEY (idCuenta) REFERENCES cuenta (id)                  
           ON DELETE NO ACTION ON UPDATE NO ACTION
         )''');

    
  }

   Future<Future<int>> insertCuenta(Cuenta cuenta) async {
    Database database = await _initDB();

    return database.insert("cuenta", cuenta.toMap());
  }

  static Future<Future<int>> updateCuenta(Cuenta cuenta) async {
    Database database = await _initDB();
    
    return database.update("cuenta", cuenta.toMap(), where: "id = ?", whereArgs: [cuenta.id]);
  }

  static Future<List<Cuenta>> listarCuentas() async {
    Database database = await _initDB();
    
    final List<Map <String, dynamic>> cuentasMap = await database.query("cuenta");

    return List.generate(cuentasMap.length,
     (i) => Cuenta(
        id: cuentasMap[i]['id'],
        nombreCuenta: cuentasMap[i]['nombreCuenta'],
        saldo: cuentasMap[i]['saldo'],
        moneda:  cuentasMap[i]['moneda'],
        color:  cuentasMap[i]['color'],
     ));
  }

 static Future<Future<int>> insertDinero(Dinero dinero) async {
    Database database = await _initDB();

    return database.insert("dinero", dinero.toMap());
  }

  static Future<Future<int>> updateDinero(Dinero dinero) async {
    Database database = await _initDB();
    
    return database.update("dinero", dinero.toMap(), where: "id = ?", whereArgs: [dinero.id]);
  }

  static Future<List<Dinero>> listarDinero() async {
    Database database = await _initDB();
    
    final List<Map <String, dynamic>> dineroMap = await database.query("dinero");

    return List.generate(dineroMap.length,
     (i) => Dinero(
        id: dineroMap[i]['id'],
        idCuenta: dineroMap[i]['idCuenta'],
        monto: dineroMap[i]['monto'],
        asunto: dineroMap[i]['asunto'],
        fechaHora:  dineroMap[i]['fechaHora'],
        tipoOperacion: dineroMap[i]['tipoOperacion']
     ));
  }




    



}