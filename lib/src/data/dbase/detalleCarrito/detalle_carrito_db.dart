import 'package:app_pedidos/src/data/dbase/dbase_db.dart';
import 'package:app_pedidos/src/data/dbase/detalleCarrito/detalle_carrito.dart';
import 'package:app_pedidos/src/data/dbase/detalleCarrito/detalle_carrito_db_event.dart';
import 'package:app_pedidos/src/global/environment.dart';
import 'package:app_pedidos/src/models/detalle_carrito.dart';

class DetalleCarritoDb implements DetalleCarritoDbEvent {
  @override
  Future<Map<String, dynamic>> guardar(
      {required String where,
      required List whereArgs,
      required DetalleCarritoModel data,
      required String origen}) async {
    final database = await DbaseDb().database;
    final db = DetalleCarrito(Environment.tableCarrito, database!);
    final respuesta = await db.guardar(
        where: where, whereArgs: whereArgs, modelo: data.toJson());

    if (respuesta.containsKey(Environment.dataOk)) {
      return {
        Environment.dataOk:
            DetalleCarritoModel.fromJson(respuesta[Environment.dataOk])
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

    DetalleCarritoModel detallecarrito =
        DetalleCarritoModel(idCarrito: whereArgs[0]);
    final db = DetalleCarrito(Environment.tableDetalleCarrito, database!);
    final respuesta = await db.leerById(where: where, whereArgs: whereArgs);

    if (respuesta.containsKey(Environment.dataOk)) {
      detallecarrito =
          DetalleCarritoModel.fromJson(respuesta[Environment.dataOk]);
    }

    if (respuesta.containsKey(Environment.dataNOk)) {
      return respuesta;
    } else {
      return {Environment.dataOk: detallecarrito};
    }
  }

  @override
  Future<Map<String, dynamic>> agrega(
      {required DetalleCarritoModel data}) async {
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
    final db = DetalleCarrito(Environment.tableDetalleCarrito, database!);
    return Future.value(db.eliminar(where: where, whereArgs: whereArgs));
  }
}
