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
            color: const Color.fromARGB(255, 212, 212, 212)
            ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 100,
            height: 30,
            color: const Color.fromARGB(255, 212, 212, 212)
            ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 153, 209, 62),
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