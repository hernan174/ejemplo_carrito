import 'package:flutter/material.dart';

class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        //color: Color.fromARGB(255, 153, 209, 62),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: const ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Image(
          image: AssetImage('assets/image2.png')
        )
      ),
    );
  }
}