import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarritoScreen extends StatefulWidget {
   
  const CarritoScreen({Key? key}) : super(key: key);

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductoBloc, ProductoState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: TabLayout(
              tabLength: state.lstProductos.length

            ),
          ),
        );
      }
    );
  }
}