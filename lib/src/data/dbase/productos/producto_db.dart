import 'package:app_pedidos/src/data/dbase/dbase_db.dart';
import 'package:app_pedidos/src/data/dbase/productos/producto.dart';
import 'package:app_pedidos/src/data/dbase/productos/producto_db_event.dart';
import 'package:app_pedidos/src/global/environment.dart';
import 'package:app_pedidos/src/models/producto.dart';

class ProductoDb implements ProductoDbEvent {
  @override
  Future<Map<String, dynamic>> guardar(
      {required String where,
      required List whereArgs,
      required ProductoModel data,
      String? origen}) async {
    final database = await DbaseDb().database;
    final db = Producto(Environment.tableProductos, database!);
    final respuesta = await db.guardar(
        where: where, whereArgs: whereArgs, modelo: data.toJson());

    if (respuesta.containsKey(Environment.dataOk)) {
      return {
        Environment.dataOk:
            ProductoModel.fromJson(respuesta[Environment.dataOk])
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

    ProductoModel producto = ProductoModel(idProducto: whereArgs[0]);
    final db = Producto(Environment.tableProductos, database!);
    final respuesta = await db.leerById(where: where, whereArgs: whereArgs);

    if (respuesta.containsKey(Environment.dataOk)) {
      producto = ProductoModel.fromJson(respuesta[Environment.dataOk]);
    }

    if (respuesta.containsKey(Environment.dataNOk)) {
      return respuesta;
    } else {
      return {Environment.dataOk: producto};
    }
  }

  @override
  Future<Map<String, dynamic>> agrega({required ProductoModel data}) async {
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
    final db = Producto(Environment.tableProductos, database!);
    return Future.value(db.eliminar(where: where, whereArgs: whereArgs));
  }

  @override
  Future<Map<String, dynamic>> obtieneProductos(
      {String? where,
      List<Object>? whereArgs,
      String? orderBy,
      int? limit}) async {
    final database = await DbaseDb().database;
    final db = Producto(Environment.tableProductos, database!);
    return Future.value(db.obtieneProductos(
        where: where, whereArgs: whereArgs, orderBy: orderBy, limit: limit));
  }
}
