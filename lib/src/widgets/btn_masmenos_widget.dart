import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/models/carrito.dart';
import 'package:app_pedidos/src/bloc/carrito/carrito_bloc.dart';

class BtnMasMenosWidget extends StatefulWidget {
  const BtnMasMenosWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<BtnMasMenosWidget> createState() => _BtnMasMenosWidgetState();
}

class _BtnMasMenosWidgetState extends State<BtnMasMenosWidget> {

  int cant = 0;
  int subtotal = 0;
  final modelo = CarritoModel(cantItems: 0, total: 0, detalleCarrito:[]);
  

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CarritoBloc, CarritoState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
      },
      builder: (context, state) {    
        return Container(
          width: 100,
          child: Row(
            children: [
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: const BoxDecoration(
                    color:  Colors.lightGreen,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                  ),
                  child: const Text('-', style: TextStyle(fontSize: 18),),
                ),
                onTap: (){
                  (cant > 0) ? cant-- : cant = 0;
                  modelo.cantItems = cant;

                  setState(() {});              
                  print(modelo.cantItems);
                },
              ),
              Container(
                color: Colors.green.shade50,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Text('$cant', style: const TextStyle(fontSize: 18),),
              ),
              GestureDetector(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: const BoxDecoration(
                    color:  Colors.lightGreen,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  ),
                  child: const Text('+', style: TextStyle(fontSize: 18),),
                ),
                onTap: (){
                  cant++;
                  modelo.cantItems = cant;
                  setState(() {});
                  print(modelo.cantItems);
                },
              ),
            ],
          ),
        );
      }
    );
  }
}