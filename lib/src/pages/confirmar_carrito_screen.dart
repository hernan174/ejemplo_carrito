import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/widgets/custom_appbar_widget.dart';

class ConfirmarScreen extends StatefulWidget {
   
  const ConfirmarScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmarScreen> createState() => _ConfirmarScreenState();
}

class _ConfirmarScreenState extends State<ConfirmarScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<CarritoBloc>().state;

    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Confirme su pedido'),
      body: Column(
        children: 
          state.lstItemCarrito
            .map((e) => Container(
              height: 80,
              child: ListView.builder(
                itemCount: 1,
                itemBuilder: (_, i) => ListTile(
                  leading: Image.file(
                    File(e.producto!.pathImagen),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  title: Text(e.producto!.nombre),
                  subtitle: Text('\$' + e.producto!.precio),
                  trailing:  IconButton(
                    icon: Icon(Icons.delete, color: Colors.orange[300]),
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
                    ),

                )
                ),
            ),).toList()
        ,
      )
    );
  }
}