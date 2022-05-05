import 'package:flutter/material.dart';


class TabsWidget extends StatefulWidget {
  const TabsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TabsWidget> createState() => _TabsWidgetState();
}

class _TabsWidgetState extends State<TabsWidget> {

  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color.fromARGB(255, 228, 228, 228),
      width: double.infinity,
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          BtnIzqWidget(),
          BtnCentroWidget(),
          BtnDerWidget()
        ],
      ),
    );
  }
}

class BtnIzqWidget extends StatefulWidget {


  const BtnIzqWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BtnIzqWidget> createState() => _BtnIzqWidgetState();
}

class _BtnIzqWidgetState extends State<BtnIzqWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        (isSelected == false) ? isSelected = true : isSelected = false;
        setState(() {});
        print(isSelected.toString());
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.lightGreen,
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
      ),
    );
  }
}

class BtnDerWidget extends StatefulWidget {
  const BtnDerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BtnDerWidget> createState() => _BtnDerWidgetState();
}

class _BtnDerWidgetState extends State<BtnDerWidget> {

  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.lightGreen,
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 5),
        decoration: const BoxDecoration(
          color:  Color.fromARGB(255, 228, 228, 228),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
        ),
        alignment: Alignment.topCenter,
        height: 32,
        width: 130,
        child: const Center(
          child: Text('Favoritos',
          style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
          )
        ),
      ),
    );
  }
}

class BtnCentroWidget extends StatelessWidget {
  const BtnCentroWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.lightGreen,
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