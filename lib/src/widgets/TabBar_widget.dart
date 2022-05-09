import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';

  
  class TabLayout extends StatefulWidget {

    final int tabLength;

    const TabLayout({Key? key, required this.tabLength,}) : super(key: key);
    @override
    State<StatefulWidget> createState() {return _TabLayoutState();}
  }
  
  class _TabLayoutState extends State<TabLayout> with TickerProviderStateMixin {

    
    late TabController _tabController;

                    
  _TabLayoutState();
  
    @override
    void initState() {
      super.initState();
      context.read<ProductoBloc>().add(OnObtieneProductos());
      _tabController = TabController(length: widget.tabLength, vsync: this);
      _tabController.animateTo(2);
    }

  
    @override
    Widget build(BuildContext context) {
      return BlocConsumer<ProductoBloc, ProductoState>(
      listenWhen: (previous, current) => !current.isWorking,
      listener: (context, state) {
        
        setState(() {
          context.read<NavBloc>().add(GetScreen('Carrito'));
        });
      },
      builder: (context, state) {
      return DefaultTabController(
          length: state.lstProductos.length,
          child: SafeArea(
            child: Column(
              children: [
                CustomAppBarWidget(title: 'Mis compras',),
                const Expanded(
                  child: MiTabBarwidget(),
                ),
                  
                BlocConsumer<CarritoBloc, CarritoState>(
                  listener: (context, state) {
                    if (state.accion == 'OnAgregaItemCarrito' && state.error.isEmpty) {
                      context.read<CarritoBloc>().add(OnGuardarCarrito());
                    }
                  },
                  builder: (context, state){
                    
                    int subtotal = 0;
                    //int precios = (state.lstItemCarrito.isEmpty) ? 0 : int.parse(state.lstItemCarrito.last.producto!.precio);
                    //subtotal = subtotal + precios;

                    state.lstItemCarrito.forEach((e) {
                      subtotal = int.parse(e.producto!.precio) + subtotal;
                      print('Nuevo item: ' + e.producto!.precio);
                      print('Subtotal actual: $subtotal');
                     });
                    

                    // state.lstItemCarrito.map((e) {
                    //   return subtotal = subtotal + int.parse(e.producto!.precio);
                    // },);


                    return Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.orange,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(state.lstItemCarrito.length.toString() + ' items  ' + '   |   Total: \$' 
                           + (subtotal).toString(), style: const TextStyle( fontSize: 20, color: Colors.white),),
                          ElevatedButton(
                            child: const Text('Ver Carrito', style: TextStyle(color: Colors.white, fontSize: 18)),
                            onPressed: () {
                              
                              Navigator.pushNamed(context, 'ConfirmarCarrito');
                            },
                          )
                        ]
                      ),
                    );
                  },
                  
                ),
                
              ],
            ),
          ),
        );
    }
      );
  }

}


class MiTabBarwidget extends StatelessWidget {

  const MiTabBarwidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productBloc = BlocProvider.of<ProductoBloc>(context);
    final lstProducts = productBloc.state.lstProductos;

    return Scaffold(
      appBar: customTabBarWidget(lstProducts),
      body: CustomTabBarViewWidget(lstProducts: lstProducts,),
    );
  }
}






  TabBar customTabBarWidget(Map<String, List<ProductoModel>> lstProducts) {
    return TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold,),
      indicatorColor: Colors.lightGreen,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: const EdgeInsets.all(5),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lightGreen,
      ),
      isScrollable: true,
      physics: const BouncingScrollPhysics(),
      onTap: (int index) {
      },
      enableFeedback: true,
      tabs: lstProducts.keys
        .map((e) => Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(e.toString().toUpperCase()))
          )
        .toList(),
    );
  }