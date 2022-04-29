import 'package:app_pedidos/src/widgets/widgets.dart';
import 'package:flutter/material.dart';


class TabsWidget extends StatelessWidget {
  const TabsWidget({
    Key? key,
  }) : super(key: key);

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