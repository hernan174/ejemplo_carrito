import 'package:flutter/material.dart';

class PromoBannerWidget extends StatelessWidget {
  const PromoBannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(
                  image: AssetImage('assets/image2.png')
                )
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image(
                  image: AssetImage('assets/image2.png')
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}