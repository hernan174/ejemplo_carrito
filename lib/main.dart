import 'package:app_pedidos/src/bloc/producto/producto_bloc.dart';
import 'package:app_pedidos/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProductoBloc()),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Delivery - App',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home: const HomeScreen());
          },
        ));
  }
}
