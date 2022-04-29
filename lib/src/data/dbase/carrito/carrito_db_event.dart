import 'package:app_pedidos/src/data/dbase/dbase_event.dart';
import 'package:app_pedidos/src/models/carrito.dart';

abstract class CarritoDbEvent extends DbaseEvent<CarritoModel> {
  Future<Map<String, dynamic>> obtieneCarritos(
      {required String where,
      required List<Object> whereArgs,
      String? orderBy,
      int? limit});
}
