part of 'producto_bloc.dart';

@immutable
abstract class ProductoEvent {}

class OnObtieneProductos extends ProductoEvent {
  OnObtieneProductos();
}

class OnNuevaProducto extends ProductoEvent {
  OnNuevaProducto();
}

class OnModificarProducto extends ProductoEvent {
  final String idProducto;

  OnModificarProducto(this.idProducto);
}

class OnValidarProducto extends ProductoEvent {
  final ProductoModel producto;

  OnValidarProducto(this.producto);
}

class OnGuardarProducto extends ProductoEvent {
  OnGuardarProducto();
}
