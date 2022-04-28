import 'package:app_pedidos/src/data/dbase/dbase.dart';
import 'package:sqflite/sqlite_api.dart';

class DetalleCarrito extends Dbase {
  DetalleCarrito(String table, Database database) : super(table, database);
}
