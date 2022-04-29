import 'package:app_pedidos/src/data/dbase/dbase_event.dart';
import 'package:app_pedidos/src/models/detalle_carrito.dart';

abstract class DetalleCarritoDbEvent extends DbaseEvent<DetalleCarritoModel> {
  Future<Map<String, dynamic>> obtieneDetalleCarrito(
      {required String where,
      required List<Object> whereArgs,
      String? orderBy,
      int? limit});
}
