import 'dart:io';

import 'package:app_pedidos/src/global/environment.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbaseDb {
  static Database? _database;

  static final DbaseDb _db = DbaseDb._();

  DbaseDb._();

  factory DbaseDb() {
    return _db;
  }

  Future<Database?> get database async {
    _database ??= await iniDB();
    return _database;
  }

  Future<Database> iniDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, Environment.dbase);
    // ignore: avoid_print
    print('=======Database:::::: $path');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE ${Environment.tableProductos}(
            idProducto INTEGER,
            Nombre TEXT,
            Precio TEXT,
            Categoria TEXT,
            PathImagen TEXT,
            PRIMARY KEY(idProducto)
          )
      ''');

      await db.execute('''
          CREATE TABLE ${Environment.tableCarrito}(
            idCarrito TEXT,
            CantItems TEXT,
            Total TEXT,
            PRIMARY KEY(idCarrito)
          )
      ''');

      await db.execute('''
          CREATE TABLE ${Environment.tableDetalleCarrito}(
            idDetalleCarrito INTEGER,
            idCarrito TEXT,
            idProducto TEXT,
            cantidad TEXT,
            PRIMARY KEY(idDetalleCarrito)
          )
      ''');
    });
  }
}
