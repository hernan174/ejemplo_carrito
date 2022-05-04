import 'package:flutter/material.dart';

class BtnMasMenosWidget extends StatefulWidget {
  const BtnMasMenosWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BtnMasMenosWidget> createState() => _BtnMasMenosWidgetState();
}
int cant = 0;
class _BtnMasMenosWidgetState extends State<BtnMasMenosWidget> {
  @override
  Widget build(BuildContext context) {

    

    return Container(
      width: 90,
      child: Row(
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: const BoxDecoration(
                color:  Colors.lightGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
              ),
              child: const Text('-', style: TextStyle(fontSize: 18),),
            ),
            onTap: (){
              (cant > 0) ? cant-- : cant = 0;
              setState(() {});              
            },
          ),
          Container(
            color: Colors.green.shade50,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Text('$cant', style: const TextStyle(fontSize: 18),),
          ),
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: const BoxDecoration(
                color:  Colors.lightGreen,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              ),
              child: const Text('+', style: TextStyle(fontSize: 18),),
            ),
            onTap: (){
              cant++;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}