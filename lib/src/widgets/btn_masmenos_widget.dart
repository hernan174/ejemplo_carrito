import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtnMaaasMeeenos extends StatefulWidget {

  List<ProductoModel> element = [];
  int index = 0;

  BtnMaaasMeeenos({
    Key? key,
    required element,
    required index
    }) : super(key: key);

  @override
  State<BtnMaaasMeeenos> createState() => _BtnMaaasMeeenosState();
}

class _BtnMaaasMeeenosState extends State<BtnMaaasMeeenos> {
  int cant = 0;
  ProductoModel alCarrito = ProductoModel();

  
  @override
  Widget build(BuildContext context) {
    return Container(
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
              alCarrito = widget.element[widget.index];
              context.read<CarritoBloc>()
              .add(OnAgregaItemCarrito(cant, widget.element[widget.index]));
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
              alCarrito = widget.element[widget.index];
              context.read<CarritoBloc>()
              .add(OnAgregaItemCarrito(cant, alCarrito ));
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}