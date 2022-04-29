import 'package:app_pedidos/src/data/dbase/productos/producto_db.dart';
import 'package:app_pedidos/src/global/environment.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:app_pedidos/src/utils/utilidades.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'producto_event.dart';
part 'producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  ProductoBloc() : super(ProductoState()) {
    on<OnObtieneProductos>(_onObtieneProductos);
    on<OnNuevaProducto>(_onNuevaProducto);
    on<OnModificarProducto>(_onModificarProducto);
    on<OnValidarProducto>(_onValidarProducto);
    on<OnGuardarProducto>(_onGuardarProducto);
  }

  Future<void> _onObtieneProductos(
      OnObtieneProductos event, Emitter emit) async {
    emit(state.copyWith(
        lstProductos: {},
        error: '',
        campoError: '',
        isWorking: true,
        accion: Environment.blocOnObtieneProductos));

    final productoDb = ProductoDb();
    Map<String, List<ProductoModel>> lstProductos = {};
    String error = '';

    ///Se obtiene todos los registros de la base de datos
    final respuesta = await productoDb.obtieneProductos();

    ///Si no hubo problema en la consulta ingresa a analizar la respuesta con los datos
    if (respuesta.containsKey(Environment.dataOk)) {
      final List<ProductoModel> lstProductosAux = respuesta[Environment.dataOk];

      ///Map de las categorias a un set se hace esto para evitar duplicados
      final Set<String> categorias =
          lstProductosAux.map((e) => e.categoria).toSet();

      ///Recorremos la lista de categoria
      for (String cat in categorias) {
        ///Ahora en base a la respuesta de la base de datos sobre los productos filtro unicamente los productos
        ///que sean igual a la categoria actual
        final productoEnCategoria =
            lstProductosAux.where((e) => e.categoria == cat).toList();
        lstProductos[cat] = productoEnCategoria;
      }
    }

    ///Si hubo algun problema lo pasa a la variable error
    else {
      error = respuesta[Environment.dataNOk];
    }
    emit(state.copyWith(
        isWorking: false,
        error: error,
        lstProductos: lstProductos,
        accion: Environment.blocOnObtieneProductos));
  }

  Future<void> _onNuevaProducto(OnNuevaProducto event, Emitter emit) async {
    emit(state.copyWith(
        producto: ProductoModel(),
        isWorking: false,
        error: '',
        campoError: '',
        accion: Environment.blocOnNuevaProducto));
  }

  Future<void> _onModificarProducto(
      OnModificarProducto event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: true, accion: Environment.blocOnModificarProducto));

    final productodb = ProductoDb();
    ProductoModel producto = ProductoModel();
    String error = '';
    final respuesta = await productodb
        .leerById(where: 'idProducto = ?', whereArgs: [event.idProducto]);

    if (respuesta.containsKey(Environment.dataNOk)) {
      error = respuesta[Environment.dataNOk];
    } else {
      producto = respuesta[Environment.dataOk];
    }
    emit(state.copyWith(
        isWorking: false,
        accion: Environment.blocOnModificarProducto,
        error: error,
        producto: producto));
  }

  Future<void> _onValidarProducto(OnValidarProducto event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: true,
        error: '',
        campoError: '',
        accion: Environment.blocOnValidarProducto));
    String error = '';
    String campoError = '';

    final producto = state.producto;

    if (event.producto.categoria.isEmpty) {
      error = 'Ingrese una categoria para el producto';
      campoError = 'Categoria';
    } else {
      producto.categoria = event.producto.categoria;
    }
    if (error.isEmpty) {
      if (event.producto.nombre.isEmpty) {
        error = 'Ingrese un nombre para el producto';
        campoError = 'Nombre';
      } else {
        producto.nombre = event.producto.nombre;
      }
    }
    if (error.isEmpty) {
      if (event.producto.precio.isEmpty) {
        error = 'Ingrese un precio para el producto';
        campoError = 'Precio';
      } else {
        producto.precio = event.producto.precio;
      }
    }
    if (error.isEmpty) {
      final existe = Utilidades.existeAchivo(event.producto.pathImagen);
      if (!existe) {
        error = 'Seleccione una imagen';
        campoError = 'Imagen';
      } else {
        producto.pathImagen = event.producto.pathImagen;
      }
    }

    emit(state.copyWith(
        isWorking: false,
        accion: Environment.blocOnValidarProducto,
        error: error,
        campoError: campoError,
        producto: producto));
  }

  Future<void> _onGuardarProducto(OnGuardarProducto event, Emitter emit) async {
    emit(state.copyWith(
        isWorking: true, accion: Environment.blocOnGuardarProducto, error: ''));

    final producto = state.producto;
    final productodb = ProductoDb();
    String error = '';

    ///Guarda el producto
    final respuesta = await productodb.guardar(
        where: 'idProducto = ?',
        whereArgs: [producto.idProducto],
        data: producto);
    if (respuesta.containsKey(Environment.dataNOk)) {
      error = respuesta[Environment.dataNOk];
    }

    ///Si no existe ningun error vuelve a obtener el listado
    if (error.isEmpty) {
      add(OnObtieneProductos());
    }
    emit(state.copyWith(
      isWorking: false,
      error: error,
      producto: ProductoModel(),
      accion: Environment.blocOnGuardarProducto,
    ));
  }
}
