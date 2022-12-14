import 'dart:io';
import 'package:flutter_application_fincet/models/Cuenta.dart';
import 'package:flutter_application_fincet/models/Gasto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Ingreso.dart';

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
    print('db location : '+path);

    return await openDatabase(path,
      version:_databaseVersion,
      onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    // SQL code to create Cuenta table
    await db.execute('''  
        CREATE TABLE cuenta (
          id INTEGER PRIMARY KEY,
          nombreCuenta TEXT NOT NULL UNIQUE,
          saldo INTEGER,
          moneda TEXT NOT NULL,
          color TEXT 
         )''');
    // SQL code to create Gasto table
    await db.execute('''  
        CREATE TABLE gasto (
          id INTEGER PRIMARY KEY ,
          idCuenta INTEGER,    
          monto INTEGER,
          asunto TEXT NOT NULL,
          fechaHora TEXT,    
          FOREIGN KEY (idCuenta) REFERENCES cuenta (id)                  
           ON DELETE NO ACTION ON UPDATE NO ACTION
         )''');

     // SQL code to create Ingreso table
    await db.execute('''  
        CREATE TABLE ingreso (
          id INTEGER PRIMARY KEY,
          idCuenta INTEGER,    
          monto INTEGER,
          asunto TEXT NOT NULL,
          fechaHora TEXT,    
          FOREIGN KEY (idCuenta) REFERENCES cuenta (id)                  
           ON DELETE NO ACTION ON UPDATE NO ACTION
         )''');
  }

   Future<Future<int>> insertCuenta(Cuenta cuenta) async {
    Database database = await _initDB();

    return database.insert("cuenta", cuenta.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
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

 static Future<Future<int>> insertIngreso(Ingreso ingreso) async {
    Database database = await _initDB();

    return database.insert("ingreso", ingreso.toMap());
  }

  static Future<Future<int>> updateIngreso(Ingreso ingreso) async {
    Database database = await _initDB();
    
    return database.update("ingreso", ingreso.toMap(), where: "id = ?", whereArgs: [ingreso.id]);
  }

  static Future<List<Ingreso>> listarIngresos() async {
    Database database = await _initDB();
    
    final List<Map <String, dynamic>> ingresosMap = await database.query("ingreso");

    return List.generate(ingresosMap.length,
     (i) => Ingreso(
        id: ingresosMap[i]['id'],
        idCuenta: ingresosMap[i]['idCuenta'],
        monto: ingresosMap[i]['monto'],
        asunto: ingresosMap[i]['asunto'],
        fechaHora:  ingresosMap[i]['fechaHora']
     ));
  }

static Future<Future<int>> insertGasto(Gasto gasto) async {
    Database database = await _initDB();

    return database.insert("gasto", gasto.toMap());
  }

  static Future<Future<int>> updateGasto(Gasto gasto) async {
    Database database = await _initDB();
    
    return database.update("gasto", gasto.toMap(), where: "id = ?", whereArgs: [gasto.id]);
  }

  static Future<List<Gasto>> listarGasto() async {
    Database database = await _initDB();
    
    final List<Map <String, dynamic>> gastosMap = await database.query("gasto");

    return List.generate(gastosMap.length,
     (i) => Gasto(
        id: gastosMap[i]['id'],
        idCuenta: gastosMap[i]['idCuenta'],
        monto: gastosMap[i]['monto'],
        asunto: gastosMap[i]['asunto'],
        fechaHora:  gastosMap[i]['fechaHora']
     ));
  }



    



}