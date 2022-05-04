import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';
import 'package:app_pedidos/src/models/producto.dart';

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
  final Widget boton = const BtnMasMenosWidget();

  bool mostrarBtn = false;

  @override
  Widget build(BuildContext context) {
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
            trailing: (!mostrarBtn)
            ?ElevatedButton(
              child: const Text('Agregar al carrito', style: TextStyle(color: Colors.white),),
              onPressed: (){
                mostrarBtn = true;
                setState(() {});
              },
            )
            : const BtnMasMenosWidget()
          )
          ),).toList()

    );
  }
}