part of 'carrito_bloc.dart';

@immutable
class CarritoState {
  final bool isWorking;
  final String accion;
  final CarritoModel carrito;
  final List<CarritoModel> lstCarritos;
  final List<DetalleCarritoModel> lstItemCarrito;
  final String error;

  CarritoState({
    this.isWorking = false,
    this.accion = '',
    CarritoModel? carrito,
    List<CarritoModel>? lstCarritos,
    List<DetalleCarritoModel>? lstItemCarrito,
    this.error = '',
  })  : carrito = carrito ?? CarritoModel(),
        lstCarritos = lstCarritos ?? [],
        lstItemCarrito = lstItemCarrito ?? [];

  CarritoState copyWith(
          {bool? isWorking,
          String? accion,
          CarritoModel? carrito,
          List<CarritoModel>? lstCarritos,
          List<DetalleCarritoModel>? lstItemCarrito,
          String? error,
          String? campoError}) =>
      CarritoState(
        isWorking: isWorking ?? this.isWorking,
        accion: accion ?? this.accion,
        error: error ?? this.error,
        carrito: carrito ?? this.carrito,
        lstCarritos: lstCarritos ?? this.lstCarritos,
        lstItemCarrito: lstItemCarrito ?? this.lstItemCarrito,
      );
}
