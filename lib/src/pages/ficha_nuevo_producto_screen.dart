import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final ImagePicker picker = ImagePicker();

  ProductoModel modeloVisual = ProductoModel();
  @override
  void initState() {
    super.initState();
    final productoState = context.read<ProductoBloc>().state.producto;
    modeloVisual.idProducto = productoState.idProducto;
    modeloVisual.categoria  = productoState.categoria;
    modeloVisual.nombre     = productoState.nombre;
    modeloVisual.precio     = productoState.precio;
    modeloVisual.pathImagen = productoState.pathImagen;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: const CustomAppBarWidget(),
        backgroundColor: const Color.fromARGB(255, 233, 245, 215),
        body: BlocConsumer<ProductoBloc, ProductoState>(
          listenWhen: (previous, current) => !current.isWorking,
          listener: (context, state) {
            
            if (state.accion == 'blocOnValidarProducto' &&
                state.error.isEmpty) {
              context.read<ProductoBloc>().add(OnGuardarProducto());
              log('======validar producto');
            }
            if (state.accion == 'blocOnGuardarProducto' &&
                state.error.isEmpty) {
              Navigator.pop(context);
              log('======guardar producto');
            }

          },
          builder: (context, state) {
            return WillPopScope(
                onWillPop: () async {
                  return !state.isWorking;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          prodNombreWidget(state),
                          const SizedBox(width: 20),
                          prodPrecioWidget(state)
                        ],
                      ),
                      Row(
                        children: [
                          prodCategoriaWidget(state),
                          
                          const SizedBox(width: 20),
                          IconButton(
                            alignment: Alignment.bottomCenter,
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? pickedFile = await picker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 100,
                              );
                              if (pickedFile == null) {
                                log('No selecciono ninguna imagen');
                                return;
                              }
                              setState(() {
                                String imagePath = pickedFile.path;
                                modeloVisual.pathImagen = imagePath;
                              });
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15,),

                      (modeloVisual.pathImagen.isEmpty)
                      ? const Image (height: 200, image: AssetImage('assets/default.png'))
                      : Column(
                          children: [
                            Hero(
                              tag: modeloVisual.idProducto ?? '',
                              child: Image.file(
                                File(modeloVisual.pathImagen),
                                height: 200,
                              )
                            ),
                            const BtnEliminarWidget(),
                          ]
                        ),
                      
                      BtnGuardarWidget(modeloVisual: modeloVisual),
                    ],
                  ),
                ));
          },
        )
      );
  }

  Widget prodCategoriaWidget(ProductoState state) {
    return Expanded(
      child: TextFormField(
        style: const TextStyle(
          fontSize: 15,
        ),
        decoration: const InputDecoration(
          labelText: 'Categoria',
        ),
        initialValue: state.producto.categoria,
        onChanged: (value) {
          modeloVisual.categoria = value;
        }),
    );
  }

  Widget prodPrecioWidget(ProductoState state) {
    return Container(
      width: 90,
      child: TextFormField(
        style: const TextStyle(
          fontSize: 15,
        ),
        decoration: const InputDecoration(
          labelText: 'Precio',
        ),
        initialValue: state.producto.precio,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'^(\d+)?\.?\d{0,2}'))
        ],
        onChanged: (value) {
          modeloVisual.precio = value;
          setState(() {});
        },
      ),
    );
  }

  Widget prodNombreWidget(ProductoState state) {
    return Expanded(
      child: TextFormField(
          style: const TextStyle(
            fontSize: 15,
          ),
          decoration: const InputDecoration(
            labelText: 'Nombre del producto',
          ),
          initialValue: state.producto.nombre,
          onChanged: (value) {
            modeloVisual.nombre = value;
            setState(() {});
          }),
    );
  }

}

class BtnEliminarWidget extends StatelessWidget {
  const BtnEliminarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange[300])),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child: const Text('Eliminar', style: TextStyle(color: Colors.white),)),
        onPressed: (){
          //context.read<ProductoBloc>().add(DeleteProducto(modeloVisual.idProducto));
          final snackBar = SnackBar(
            duration: const Duration(milliseconds: 500),
            content: const Text('Registro eliminado'),
            action: SnackBarAction(
              label: 'Entendido',
              onPressed: () {},
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
    );
  }
}

class BtnGuardarWidget extends StatelessWidget {
  const BtnGuardarWidget({
    Key? key,
    required this.modeloVisual,
  }) : super(key: key);

  final ProductoModel modeloVisual;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Colors.lightGreen),
        ),
        child: const SizedBox(
            width: double.infinity,
            child: Center(
                child: Text(
              'Guardar',
              style: TextStyle(color: Colors.white),
            ))),
        onPressed: () {
          context
              .read<ProductoBloc>()
              .add(OnValidarProducto(modeloVisual));
        });
  }
}
