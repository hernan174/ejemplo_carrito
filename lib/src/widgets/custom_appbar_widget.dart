import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  String title;

  @override
  Size get preferredSize => const Size.fromHeight(55);
  CustomAppBarWidget({
    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white,),
        onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      elevation: 0,
      title: Text(title, style: const TextStyle(color: Colors.white),),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white,),
            onPressed: () {
              Navigator.pushNamed(context, 'Carrito');
             },
            ),
        )
      ],
    );
  }
}