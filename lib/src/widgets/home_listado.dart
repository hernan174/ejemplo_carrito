import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListadoWidget extends StatefulWidget {
  const ListadoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListadoWidget> createState() => _ListadoWidgetState();
}

class _ListadoWidgetState extends State<ListadoWidget> {
  @override
  Widget build(BuildContext context) {
    final state = context.read<ProductoBloc>().state;
    return Expanded(
        child: ListView(children: [
      ...state.lstProductos.entries
          .map((e) => ItemHomeViewWidget(
              categoria: e.key, productos: e.value))
          .toList()
      ])
    );
  }
}