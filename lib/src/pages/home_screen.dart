import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<ProductoBloc>().add(OnObtieneProductos());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductoBloc, ProductoState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        if (state.accion == 'blocOnNuevaProducto' ||
            state.accion == 'blocOnModificarProducto') {
          Navigator.pushNamed(context, 'NewProduct');
          log('======>Navigator.pushNamed(context, NewProduct)');
        }
        setState(() {
          context.read<NavBloc>().add(GetScreen('Home'));
        });
      },
      builder: (context, state) {
        return Scaffold(
          drawer: const CustomDrawer(),
          appBar: const CustomAppBarWidget(),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300]
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  const HeaderWidget(),
                  const TabsWidget(),
                  //TabLayoutExample(),
                  ListadoWidget()
                ],
              ),
            ),
          )
        );
      },
    );
  }
}