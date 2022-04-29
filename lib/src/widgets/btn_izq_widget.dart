import 'package:flutter/material.dart';

class BtnIzqWidget extends StatelessWidget {
  const BtnIzqWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 153, 209, 62),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        decoration: const BoxDecoration(
          color:  Color.fromARGB(255, 228, 228, 228),
          borderRadius: BorderRadius.only(topRight: Radius.circular(15)),
        ),
        alignment: Alignment.topCenter,
        height: 32,
        width: 130,
        child: const Center(
          child: Text('Ofertas',
          style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
          )
        ),
      ),
    );
  }
}