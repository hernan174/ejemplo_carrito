import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/utils/utils.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/pages/pages.dart';
import 'package:app_pedidos/src/bloc/simple_bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(() async {
    runApp(const MyApp());
  }, blocObserver: SimpleBlocObserver());
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom, 
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ProductoBloc()),
          BlocProvider(create: (_) => NavBloc()),
          BlocProvider(create: (_) => CarritoBloc()),
        ],
        child: Builder(
          builder: (context) {
            return DismissKeyboard(
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Delivery - App',
                  theme: ThemeData(
                    primarySwatch: Colors.lightGreen,
                  ),
                  initialRoute: 'Home',
                  routes: {
                    'Home'             : (_) => const HomeScreen(),
                    'NewProduct'       : (_) => const NewProductScreen(),
                    'Carrito'          : (_) => const CarritoScreen(),
                    'ConfirmarCarrito' : (_) => const ConfirmarScreen(),
                    'Pagos'            : (_) => const PagosScreen(),
                  }),
            );
          },
        ));
  }
}
