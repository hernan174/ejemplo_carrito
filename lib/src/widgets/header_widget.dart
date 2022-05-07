import 'package:app_pedidos/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: 100,
            height: 30,
            color: Colors.grey[300]
            ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 100,
            height: 30,
            color: Colors.grey[300]
            ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          ),
          child: Column(
            children: const [
              BusquedaWidget(),
              PromoBannerWidget(),
            ],
          ),
    )
      ],
    );
  }
}