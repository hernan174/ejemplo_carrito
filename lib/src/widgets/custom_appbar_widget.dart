import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget{

  @override
  Size get preferredSize => const Size.fromHeight(50);
  const CustomAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      elevation: 0,
      backgroundColor: const Color.fromARGB(255, 153, 209, 62),
      title: const Text('Delivery App'),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, 'Carrito');
             },
            ),
        )
      ],
    );
  }
}