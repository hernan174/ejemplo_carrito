import 'package:flutter/material.dart';

class BtnCentroWidget extends StatelessWidget {
  const BtnCentroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 153, 209, 62),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      alignment: Alignment.topCenter,
      height: 32,
      child: const Center(
        child: Text('Categorias',
        style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
        )
      ),
    );
  }
}