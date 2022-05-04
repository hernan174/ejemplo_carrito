import 'package:flutter/material.dart';

class BtnMasMenosWidget extends StatelessWidget {
  const BtnMasMenosWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: const BoxDecoration(
              color:  Color.fromARGB(255, 153, 209, 62),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            ),
            child: const Text('-', style: TextStyle(fontSize: 18),),
          ),
          Container(
            color: Colors.green.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: const Text('1', style: TextStyle(fontSize: 18),),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: const BoxDecoration(
              color:  Color.fromARGB(255, 153, 209, 62),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            ),
            child: const Text('+', style: TextStyle(fontSize: 18),),
          ),
        ],
      ),
    );
  }
}