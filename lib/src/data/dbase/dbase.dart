import 'package:app_pedidos/src/global/environment.dart';
import 'package:sqflite/sqflite.dart';

class Dbase {
  final String table;
  final Database database;

  Dbase(this.table, this.database);

  Future<Map<String, dynamic>> guardar(
      {required String where,
      required List<dynamic> whereArgs,
      required Map<String, dynamic> modelo}) async {
    try {
      Map<String, dynamic> resultado;
      final respuesta = await leerById(where: where, whereArgs: whereArgs);
      if (respuesta.containsKey(Environment.dataOk)) {
        resultado = await _modificar(
            where: where, whereArgs: whereArgs, modelo: modelo);
      } else {
        resultado = await agregar(modelo: modelo);
      }
      return resultado;
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  Future<Map<String, dynamic>> leerById({
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    try {
      final respuesta =
          await database.query(table, where: where, whereArgs: whereArgs);
      if (respuesta.isNotEmpty) {
        return {Environment.dataOk: respuesta.first};
      }
      return {Environment.dataNOk: 'No Existen Datos'};
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  Future<Map<String, dynamic>> _modificar(
      {required String where,
      required List<dynamic> whereArgs,
      required Map<String, dynamic> modelo}) async {
    try {
      final respuesta = await database.update(table, modelo,
          where: where, whereArgs: whereArgs);
      if (respuesta > 0) {
        return {Environment.dataOk: modelo};
      }
      return {Environment.dataNOk: 'Error No se Puedo Actualiar el SQL'};
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  Future<Map<String, dynamic>> agregar(
      {required Map<String, dynamic> modelo}) async {
    try {
      final respuesta = await database.insert(table, modelo);
      if (respuesta > 0) {
        return {Environment.dataOk: modelo};
      }
      return {Environment.dataNOk: 'Error No se Puedo Actualiar el SQL'};
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }

  Future<Map<String, dynamic>> eliminar(
      {required String where, required List<dynamic> whereArgs}) async {
    try {
      final respuesta =
          await database.delete(table, where: where, whereArgs: whereArgs);
      if (respuesta > 0) {
        return {Environment.dataOk: true};
      }
      return {Environment.dataNOk: 'Error No se Puedo Actualiar el SQL'};
    } catch (error) {
      return {Environment.dataNOk: error.toString()};
    }
  }
}
