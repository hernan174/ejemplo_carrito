import 'package:app_pedidos/src/bloc/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/pages/pages.dart';

void main() {
  BlocOverrides.runZoned(() async {
    runApp(const MyApp());
  }, blocObserver: SimpleBlocObserver());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProductoBloc()),
          BlocProvider(create: (_) => NavBloc()),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Delivery - App',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                initialRoute: 'Home',
                routes: {
                  'Home': (_) => const HomeScreen(),
                  'NewProduct': (_) => const NewProductScreen(),
                  'Carrito' : (_) => const CarritoScreen(),
                });
          },
        ));
  }
}
