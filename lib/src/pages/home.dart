import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';




class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<ProductoBloc, ProductoState>(
      listenWhen:(previous, current) => !current.isWorking,
      listener: (context, state){ },
      builder: (context, state){
        return Scaffold(
        appBar: const CustomAppBarWidget(),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 212, 212, 212)
            ),
            width: double.infinity,
            child:  Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                
                children:  [
                  const HeaderWidget(),
                  const TabsWidget(),
                  
                  ItemHomeViewWidget(categoria: state.lstProductos[0].toString(), productos: state.lstProductos[1]!,),



                ],
              ),
            ),
          ),
        )
      );
      },
    );
    
  }
}