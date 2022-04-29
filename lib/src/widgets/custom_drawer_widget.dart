import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: ((context, state) {
        return Drawer(
          backgroundColor: Color.fromARGB(255, 150, 185, 97),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child:  Icon(
                  Icons.shopping_basket_outlined,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: const Text(
                  'Inicio',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                onTap: () {
                  // if (state.screen != 'Home') {
                  //   setState(() {
                  //     context.read<NavBloc>().add(GetScreen('Home'));
                  //   });        
                  //   Navigator.pushReplacementNamed(context, 'Home');
                  // } else {
                  //   Navigator.pop(context);
                  // }
                },
              ),
                        ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: const Text(
                  'Nuevo Producto',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
                ),
                onTap: () {
                  if (state.screen != 'NewProduct') {
                    setState(() {
                      context.read<NavBloc>().add(GetScreen('NewProduct'));
                    });        
                    Navigator.pushReplacementNamed(context, 'NewProduct');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      })
    );
  }
}