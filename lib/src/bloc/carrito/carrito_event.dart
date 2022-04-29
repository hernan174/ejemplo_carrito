part of 'carrito_bloc.dart';

@immutable
abstract class CarritoEvent {}

class OnObtieneCarritos extends CarritoEvent {
  OnObtieneCarritos();
}

class OnNuevaCarrito extends CarritoEvent {
  OnNuevaCarrito();
}

///Evento para agregar un nuevo item al carrito
///[cantidad] Es la cantidad de elementos seleccionos
///[producto] Es el producto que se va a agregar al carrito
class OnAgregaItemCarrito extends CarritoEvent {
  final int cantidad;
  final ProductoModel producto;

  OnAgregaItemCarrito(this.cantidad, this.producto);
}

class OnGuardarCarrito extends CarritoEvent {
  OnGuardarCarrito();
}

class OnObtieneItemsCarrito extends CarritoEvent {
  final int idCarrito;
  OnObtieneItemsCarrito(this.idCarrito);
}
