import 'package:app_pedidos/src/data/dbase/detalleCarrito/detalle_carrito_db.dart';
import 'package:app_pedidos/src/data/dbase/productos/producto_db.dart';
import 'package:app_pedidos/src/models/detalle_carrito.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:app_pedidos/src/data/dbase/carrito/carrito_db.dart';
import 'package:app_pedidos/src/global/environment.dart';
import 'package:app_pedidos/src/models/carrito.dart';

part 'carrito_event.dart';
part 'carrito_state.dart';

class CarritoBloc extends Bloc<CarritoEvent, CarritoState> {
  CarritoBloc() : super(CarritoState()) {
    on<OnObtieneCarritos>(_onObtieneCarritos);
    on<OnNuevaCarrito>(_onNuevaCarrito);
    on<OnAgregaItemCarrito>(_onAgregaItemCarrito);
    on<OnObtieneItemsCarrito>(_onObtieneItemsCarrito);
    on<OnGuardarCarrito>(_onGuardarCarrito);
  }

  Future<void> _onObtieneCarritos(OnObtieneCarritos event, Emitter emit) async {
    emit(state.copyWith(
        lstCarritos: [],
        lstItemCarrito: [],
        error: '',
        campoError: '',
        isWorking: true,
        accion: Environment.blocOnObtieneCarritos));

    final carritoDb = CarritoDb();
    List<CarritoModel> lstCarritos = [];
    String error = '';

    ///Se obtiene todos los registros de la base de datos
    final respuesta = await carritoDb.obtieneCarritos();

    ///Si no hubo problema en la consulta ingresa a analizar la respuesta con los datos
    if (respuesta.containsKey(Environment.dataOk)) {
      lstCarritos = respuesta[Environment.dataOk];
    }

    ///Si hubo algun problema lo pasa a la variable error
    else {
      error = respuesta[Environment.dataNOk];
    }
    emit(state.copyWith(
        isWorking: false,
        error: error,
        lstCarritos: lstCarritos,
        accion: Environment.blocOnObtieneCarritos));
  }

  Future<void> _onNuevaCarrito(OnNuevaCarrito event, Emitter emit) async {
    emit(state.copyWith(
        carrito: CarritoModel(),
        lstItemCarrito: [],
        isWorking: false,
        error: '',
        campoError: '',
        accion: Environment.blocOnNuevaCarrito));
  }

  Future<void> _onAgregaItemCarrito(
      OnAgregaItemCarrito event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: true,
        accion: Environment.blocOnAgregaItemCarrito,
        error: ''));
    final lstItemCarrito = state.lstItemCarrito;
    String error = '';
    if (event.cantidad < 1) {
      error = 'Ingrese la cantidad de items';
    }
    if (error.isEmpty) {
      if (event.producto.idProducto != null && event.producto.idProducto! < 0) {
        error = 'Falta determinar el producto';
      }
    }
    if (error.isEmpty) {
      DetalleCarritoModel nuevoItem = DetalleCarritoModel();
      nuevoItem.cantidad = event.cantidad;
      nuevoItem.idCarrito = state.carrito.idCarrito ?? 0;
      nuevoItem.idProducto = event.producto.idProducto ?? 0;
      nuevoItem.producto = event.producto;
      lstItemCarrito.add(nuevoItem);
    }

    emit(state.copyWith(
        isWorking: false,
        lstItemCarrito: lstItemCarrito,
        accion: Environment.blocOnAgregaItemCarrito,
        error: error));
  }

  Future<void> _onObtieneItemsCarrito(
      OnObtieneItemsCarrito event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: true,
        accion: Environment.blocOnObtieneItemsCarrito,
        error: ''));

    final productoDb = ProductoDb();
    final detalleCarritoDb = DetalleCarritoDb();
    String error = '';
    List<DetalleCarritoModel> lstItemCarrito = [];

    ///Obtiene los detalles del carrito
    final respuesta = await detalleCarritoDb.obtieneDetalleCarrito(
        where: 'idCarrito = ?', whereArgs: [event.idCarrito]);
    if (respuesta.containsKey(Environment.dataNOk)) {
      error = respuesta[Environment.dataNOk];
    }
    if (error.isEmpty) {
      lstItemCarrito = respuesta[Environment.dataOk];
      for (DetalleCarritoModel item in lstItemCarrito) {
        final respuesta = await productoDb
            .leerById(where: 'idProducto = ?', whereArgs: [item.idProducto]);
        if (respuesta.containsKey(Environment.dataNOk)) {
          error = respuesta[Environment.dataNOk];
        }
        if (error.isNotEmpty) {
          ///TODO aca se podria hacer algun tratamiento en caso de error
          break;
        }
        item.producto = respuesta[Environment.dataOk];
      }
    }

    emit(state.copyWith(
        isWorking: false,
        accion: Environment.blocOnObtieneItemsCarrito,
        lstItemCarrito: lstItemCarrito,
        error: ''));
  }

  Future<void> _onGuardarCarrito(OnGuardarCarrito event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: true, accion: Environment.blocOnGuardarCarrito, error: ''));

    CarritoModel carrito = state.carrito;
    final detalleCarrito = state.lstItemCarrito;

    final carritoDb = CarritoDb();
    final detalleCarritoDb = DetalleCarritoDb();
    String error = '';

    ///Guarda el carrito
    final respuesta = await carritoDb.guardar(
        where: 'idCarrito = ?', whereArgs: [carrito.idCarrito], data: carrito);
    if (respuesta.containsKey(Environment.dataNOk)) {
      error = respuesta[Environment.dataNOk];
    }

    if (error.isEmpty) {
      carrito = respuesta[Environment.dataOk];
      for (DetalleCarritoModel item in detalleCarrito) {
        final respuesta = await detalleCarritoDb.guardar(
            where: 'idDetalleCarrito = ? AND idCarrito = ?',
            whereArgs: [item.idDetalleCarrito, carrito.idCarrito],
            data: item);
        if (respuesta.containsKey(Environment.dataNOk)) {
          error = respuesta[Environment.dataNOk];
        }
        if (error.isNotEmpty) {
          ///TODO Se podria agregar que borre los items que haya guardado y el carrito
          break;
        }
      }
    }

    ///Si no existe ningun error vuelve a obtener el listado
    if (error.isEmpty) {
      add(OnObtieneCarritos());
    }
    emit(state.copyWith(
      isWorking: false,
      error: error,
      carrito: CarritoModel(),
      lstItemCarrito: [],
      accion: Environment.blocOnGuardarCarrito,
    ));
  }
}
