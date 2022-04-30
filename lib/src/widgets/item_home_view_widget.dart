import 'package:flutter/material.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blocs.dart';

class ItemHomeViewWidget extends StatelessWidget {
  const ItemHomeViewWidget({
    Key? key,
    required this.categoria,
    required this.productos,
  }) : super(key: key);

  final String categoria;
  final List<ProductoModel> productos;

  @override
  Widget build(BuildContext context) {
    return ExpandCategorias(categoria: categoria, productos: productos);
  }
}

class Item {
  Item({
    required this.productos,
    required this.categoria,
    this.isExpanded = false,
  });

  List<ProductoModel> productos;
  String categoria;
  bool isExpanded;
}

class ExpandCategorias extends StatefulWidget {
  final String categoria;
  final List<ProductoModel> productos;

  const ExpandCategorias({
    Key? key,
    required this.categoria,
    required this.productos,
  }) : super(key: key);

  @override
  State<ExpandCategorias> createState() => _ExpandCategoriasState();
}

class _ExpandCategoriasState extends State<ExpandCategorias> {
  late Item _data;

  @override
  void initState() {
    super.initState();
    _data = Item(productos: widget.productos, categoria: widget.categoria);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return Theme(
            data: Theme.of(context).copyWith(cardColor: const Color.fromARGB(255, 233, 245, 215)),
            child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data.isExpanded = !isExpanded;
          });
        },
        children: [
          ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                leading: const Icon(Icons.grass_sharp),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(_data.categoria, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              );
            },
            body: _ItemExpancionPanel(productos: _data.productos),
            isExpanded: _data.isExpanded,
          )
        ])
    );
    
  }
}

class _ItemExpancionPanel extends StatelessWidget {
  const _ItemExpancionPanel({
    Key? key,
    required this.productos,
  }) : super(key: key);

  final List<ProductoModel> productos;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.white,
      child: Wrap(
        children: productos
            .map((e) => _ItemProducto(
                  producto: e,
                ))
            .toList(),
      ),
    );
  }
}

class _ItemProducto extends StatelessWidget {
  const _ItemProducto({
    Key? key,
    required this.producto,
  }) : super(key: key);
  final ProductoModel producto;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        context
          .read<ProductoBloc>()
          .add(OnModificarProducto(producto.idProducto.toString()));
      }),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          
          children: [
            const Image(
              width: 60,
              image: AssetImage('assets/comida.png') 
            ),
            Text(producto.nombre),
          ],
        ),
      ),
    );
  }
}
