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
        //backgroundColor: const Color.fromARGB(255, 153, 209, 62),
        appBar: const CustomAppBarWidget(),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            //color: const Color.fromARGB(255, 153, 209, 62),
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
                  
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    color: const Color.fromARGB(255, 212, 212, 212),
                    width: double.infinity,
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 153, 209, 62),
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                          ),
                          alignment: Alignment.topCenter,
                          height: 32,
                          width: 150,
                          child: const Center(
                            child: Text('Categorias',
                            style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600),
                            )
                          ),
                        )
                      ],
                    ),
                  ),
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