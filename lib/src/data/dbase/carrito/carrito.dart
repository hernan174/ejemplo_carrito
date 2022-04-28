import 'package:app_pedidos/src/data/dbase/dbase.dart';
import 'package:sqflite/sqlite_api.dart';

class Carrito extends Dbase {
  Carrito(String table, Database database) : super(table, database);
}
