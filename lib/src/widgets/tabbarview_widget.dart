import 'dart:io';
import 'package:app_pedidos/src/models/detalle_carrito.dart';
import 'package:flutter/material.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/blocs.dart';

class CustomTabBarViewWidget extends StatefulWidget {
  CustomTabBarViewWidget({
    Key? key,
    required this.lstProducts,
  }) : super(key: key);

  final Map<String, List<ProductoModel>> lstProducts;
  
  @override
  State<CustomTabBarViewWidget> createState() => _CustomTabBarViewWidgetState();
}

class _CustomTabBarViewWidgetState extends State<CustomTabBarViewWidget> {
  
  bool mostrarBtn = false;
  
    int cant = 0;
  @override
  Widget build(BuildContext context) {
    
    DetalleCarritoModel alCarrito = DetalleCarritoModel();

    return TabBarView(
      physics: const BouncingScrollPhysics(),
      children: widget.lstProducts.values
        .map((e) => ListView.builder(
          itemCount: e.length,
          itemBuilder: (_, i) => ListTile(
            leading: Image.file(
              File(e[i].pathImagen),
              height: 100,
              width: 100,
              alignment: Alignment.bottomCenter,
              fit: BoxFit.cover,
            ),
            title: Text(e[i].nombre),
            subtitle: Text('\$' + e[i].precio),
            trailing: 
            
            (!mostrarBtn)
            ?ElevatedButton(
              child: const Text('Agregar al carrito', style: TextStyle(color: Colors.white),),
              onPressed: (){
                mostrarBtn = true;
                setState(() {});
              },
            )
            : Container(
              
              width: 100,
              child: Row(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: const BoxDecoration(
                        color:  Colors.lightGreen,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      ),
                      child: const Text('-', style: TextStyle(fontSize: 18),),
                    ),
                    onTap: (){
                      (cant > 0) ? cant-- : cant = 0;
                      alCarrito.cantidad = cant;

                      context.read<CarritoBloc>()
                      .add(OnAgregaItemCarrito(cant, e[i]));
                      setState(() {});
                    },
                  ),
                  Container(
                    color: Colors.green.shade50,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    child: Text('$cant', style: const TextStyle(fontSize: 18),),
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: const BoxDecoration(
                        color:  Colors.lightGreen,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      ),
                      child: const Text('+', style: TextStyle(fontSize: 18),),
                    ),
                    onTap: (){
                      cant++;
                      alCarrito.cantidad = cant;
                      alCarrito.idProducto = e[i].idProducto!;
                      
                      context.read<CarritoBloc>()
                      .add(OnAgregaItemCarrito(cant, e[i] ));
                      setState(() {});

                    },
                  ),
                ],
              ),
            )
            
            
            
          )
          ),).toList()

    );
  }
}