import 'package:app_pedidos/src/data/dbase/dbase.dart';
import 'package:app_pedidos/src/global/environment.dart';
import 'package:app_pedidos/src/models/carrito.dart';
import 'package:sqflite/sqlite_api.dart';

class Carrito extends Dbase {
  Carrito(String table, Database database) : super(table, database);

  Future<Map<String, dynamic>>? obtieneCarritos(
      {String? where,
      List<Object>? whereArgs,
      String? orderBy,
      int? limit}) async {
    try {
      final respuesta = await database.query(table,
          where: where, whereArgs: whereArgs, orderBy: orderBy, limit: limit);
      if (respuesta.isNotEmpty) {
        final data =
            respuesta.map((element) => CarritoModel.fromJson(element)).toList();

        return {Environment.dataOk: data};
      }
      throw 'No Existen Datos';
    } catch (error) {
      return {Environment.dataNOk: error};
    }
  }
}
