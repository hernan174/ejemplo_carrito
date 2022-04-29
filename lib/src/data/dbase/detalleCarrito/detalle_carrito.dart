import 'package:app_pedidos/src/data/dbase/dbase.dart';
import 'package:app_pedidos/src/global/environment.dart';
import 'package:app_pedidos/src/models/detalle_carrito.dart';
import 'package:sqflite/sqlite_api.dart';

class DetalleCarrito extends Dbase {
  DetalleCarrito(String table, Database database) : super(table, database);

  Future<Map<String, dynamic>> obtieneDetalleCarrito(
      {required String where,
      required List<Object> whereArgs,
      String? orderBy,
      int? limit}) async {
    try {
      final respuesta = await database.query(table,
          where: where, whereArgs: whereArgs, orderBy: orderBy, limit: limit);
      if (respuesta.isNotEmpty) {
        final data = respuesta
            .map((element) => DetalleCarritoModel.fromJson(element))
            .toList();

        return {Environment.dataOk: data};
      }
      throw 'No Existen Datos';
    } catch (error) {
      return {Environment.dataNOk: error};
    }
  }
}
