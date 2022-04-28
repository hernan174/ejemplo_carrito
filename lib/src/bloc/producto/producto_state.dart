part of 'producto_bloc.dart';

@immutable
class ProductoState {
  final bool isWorking;
  final String accion;
  final ProductoModel producto;
  final Map<String, List<ProductoModel>> lstProductos;
  final String error;
  final String campoError;

  ProductoState({
    this.isWorking = false,
    this.accion = '',
    ProductoModel? producto,
    Map<String, List<ProductoModel>>? lstProductos,
    this.error = '',
    this.campoError = '',
  })  : producto = producto ?? ProductoModel(),
        lstProductos = lstProductos ?? {};

  ProductoState copyWith(
          {bool? isWorking,
          String? accion,
          ProductoModel? producto,
          Map<String, List<ProductoModel>>? lstProductos,
          String? error,
          String? campoError}) =>
      ProductoState(
          isWorking: isWorking ?? this.isWorking,
          accion: accion ?? this.accion,
          producto: producto ?? this.producto,
          lstProductos: lstProductos ?? this.lstProductos,
          error: error ?? this.error,
          campoError: campoError ?? this.campoError);
}
