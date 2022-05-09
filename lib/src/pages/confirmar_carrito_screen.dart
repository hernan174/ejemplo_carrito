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
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Confirme su pedido'),
      body: BlocConsumer<CarritoBloc, CarritoState>(
        listener: (context, state) {
          
        },
        builder: (context, state){
          return Column(
            children:          
              state.lstItemCarrito
                .map((e) => Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.lstItemCarrito.length,
                    itemBuilder: (_, i) => ListTile(
                      leading: Image.file(
                        File(e.producto!.pathImagen),
                        height: 100,
                        width: 100,
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.cover,
                      ),
                      title: Text(e.producto!.nombre),
                      subtitle: Text('\$' + e.producto!.precio),
                          
                    )
                    ),
                ),).toList()
            
          );
        }
      )
    );
  }
}