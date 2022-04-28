import 'package:flutter/material.dart';

class BusquedaWidget extends StatelessWidget {
  const BusquedaWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.grey),
        decoration: const InputDecoration(
          icon: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.search, size: 30, color: Color.fromARGB(255, 153, 209, 62),),
          ),
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
          hintText: 'Realice una busqueda',
          border: InputBorder.none
          ),
        //decoration: ,
      )
    );
  }
}