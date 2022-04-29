import 'package:flutter/material.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    //Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Delivery - App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
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
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 153, 209, 62),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                    ),
                    child: Column(
                      children: const [
                        BusquedaWidget(),
                        PromoBannerWidget(),
                      ],
                    ),
                  ),
                  
                  const TabsWidget(),
                  const ItemHomeViewWidget(categoria: 'algo', productos: [],),



                ],
              ),
            ),
          ),
        )
        
      ),
    );
  }
}