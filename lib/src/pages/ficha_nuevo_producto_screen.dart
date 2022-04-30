import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';

class NewProductScreen extends StatefulWidget {
   
  const NewProductScreen({Key? key}) : super(key: key);

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {

  final ImagePicker picker = ImagePicker();

  String tempCategoria = '';
  String tempNombre = '';
  String tempPrecio = '';
  String tempPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(),
      backgroundColor: const Color.fromARGB(255, 233, 245, 215),
      body: BlocConsumer<ProductoBloc, ProductoState>(
        listenWhen: (previous, current) => !current.isWorking,
        listener: (context, state) {
          if (state.accion == 'blocOnValidarProducto' && state.error.isEmpty) {
            context.read<ProductoBloc>().add(OnGuardarProducto());
            log('======validar producto');
          }  
          if (state.accion == 'blocOnGuardarProducto' && state.error.isEmpty) {
            Navigator.pushNamed(context, 'Home');
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
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Nombre del producto',
                          ),
                          initialValue: state.producto.nombre,
                          onChanged: (value) {
                            tempNombre = value;
                            setState(() {
                              
                            });
                          }
                        ),
                      ),
                      const SizedBox(width: 20),
                      Container(
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
                            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                          ],
                          onChanged: (value) {
                            tempPrecio = value;
                            setState(() {
                              
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                          decoration: const InputDecoration(
                            labelText: 'Categoria',
                          ),
                          initialValue: state.producto.categoria,
                          onChanged: (value) {
                            tempCategoria = value;
                          }
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        alignment: Alignment.bottomCenter,
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                            source: ImageSource.gallery,
                            imageQuality: 100,
                          );
                          if( pickedFile==null){
                            print('No selecciono ninguna imagen');
                            return;
                          }
                          String imagePath = pickedFile.path;
                          tempPath = imagePath;
                          setState(() {
                            tempPath;
                          });
                        },
                        icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.grey,),
                      ),
                    ],
                  ),
                  Container(
                    child: Image.file(
                      File(tempPath),
                      scale: 0.5,
                    )
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 153, 209, 62)),
                    ),
                    child: const SizedBox(
                      width: double.infinity,
                      child: Center(child: Text('Guardar', style: TextStyle(color: Colors.white),))
                    ),
                    onPressed: () {
                      final productoState = BlocProvider.of<ProductoBloc>(context).state.producto;

                      productoState.categoria  = tempCategoria;
                      productoState.nombre     = tempNombre;
                      productoState.precio     = tempPrecio;
                      productoState.pathImagen = tempPath;

                      context
                        .read<ProductoBloc>()
                        .add(OnValidarProducto( productoState ));

                    }
                  ),
                ],
              ),
            )
          );
        },
      )
    );
  }
}