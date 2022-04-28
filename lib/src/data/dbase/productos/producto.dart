import 'package:app_pedidos/src/data/dbase/dbase.dart';
import 'package:sqflite/sqlite_api.dart';

class Producto extends Dbase {
  Producto(String table, Database database) : super(table, database);
}
