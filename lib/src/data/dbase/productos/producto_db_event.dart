import 'package:app_pedidos/src/data/dbase/dbase_event.dart';
import 'package:app_pedidos/src/models/producto.dart';

abstract class ProductoDbEvent extends DbaseEvent<ProductoModel> {
  Future<Map<String, dynamic>> obtieneProductos(
      {required String where,
      required List<Object> whereArgs,
      String? orderBy,
      int? limit});
}
