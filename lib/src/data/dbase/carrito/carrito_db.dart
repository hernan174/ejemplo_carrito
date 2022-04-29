import 'package:app_pedidos/src/data/dbase/carrito/carrito.dart';
import 'package:app_pedidos/src/data/dbase/carrito/carrito_db_event.dart';
import 'package:app_pedidos/src/data/dbase/dbase_db.dart';
import 'package:app_pedidos/src/global/environment.dart';
import 'package:app_pedidos/src/models/carrito.dart';

class CarritoDb implements CarritoDbEvent {
  @override
  Future<Map<String, dynamic>> guardar(
      {required String where,
      required List whereArgs,
      required CarritoModel data,
      String? origen}) async {
    final database = await DbaseDb().database;
    final db = Carrito(Environment.tableCarrito, database!);
    final respuesta = await db.guardar(
        where: where, whereArgs: whereArgs, modelo: data.toJson());

    if (respuesta.containsKey(Environment.dataOk)) {
      return {
        Environment.dataOk: CarritoModel.fromJson(respuesta[Environment.dataOk])
      };
    }
    return respuesta;
  }

  @override
  Future<Map<String, dynamic>> leerById(
      {required String where,
      required List whereArgs,
      bool? downloadImagen}) async {
    final database = await DbaseDb().database;

    CarritoModel carrito = CarritoModel(idCarrito: whereArgs[0]);
    final db = Carrito(Environment.tableCarrito, database!);
    final respuesta = await db.leerById(where: where, whereArgs: whereArgs);

    if (respuesta.containsKey(Environment.dataOk)) {
      carrito = CarritoModel.fromJson(respuesta[Environment.dataOk]);
    }

    if (respuesta.containsKey(Environment.dataNOk)) {
      return respuesta;
    } else {
      return {Environment.dataOk: carrito};
    }
  }

  @override
  Future<Map<String, dynamic>> agrega({required CarritoModel data}) async {
    try {
      throw 'Sin Implementar agrega';
    } catch (error) {
      return {Environment.dataNOk: error};
    }
  }

  @override
  Future<Map<String, dynamic>> eliminar(
      {required String where, required List whereArgs}) async {
    final database = await DbaseDb().database;
    final db = Carrito(Environment.tableCarrito, database!);
    return Future.value(db.eliminar(where: where, whereArgs: whereArgs));
  }

  @override
  Future<Map<String, dynamic>> obtieneCarritos(
      {required String where,
      required List<Object> whereArgs,
      String? orderBy,
      int? limit}) async {
    final database = await DbaseDb().database;
    final db = Carrito(Environment.tableCarrito, database!);
    return Future.value(db.obtieneCarritos(
        where: where, whereArgs: whereArgs, orderBy: orderBy, limit: limit));
  }
}
