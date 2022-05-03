import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';

  
  class TabLayout extends StatefulWidget {

    final int tabLength;

  const TabLayout({Key? key, required this.tabLength,}) : super(key: key);
    @override
    State<StatefulWidget> createState() {
      return _TabLayoutState(tabLength);
    }
  
  }
  
  class _TabLayoutState extends State<TabLayout> with TickerProviderStateMixin {

    final int tabLength;
    late TabController _tabController;

  _TabLayoutState(this.tabLength);
  
    @override
    void initState() {
      super.initState();
      context.read<ProductoBloc>().add(OnObtieneProductos());
      _tabController = TabController(length: tabLength, vsync: this);
      _tabController.animateTo(2);
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
          context.read<NavBloc>().add(GetScreen('Carrito'));
        });
      },
      builder: (context, state) {
      return DefaultTabController(
          length: state.lstProductos.length,
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  height: 50,
                  width: double.infinity,
                  child: const Text(
                    'Mis Compras', 
                    style: TextStyle(fontSize:20, color: Colors.white, fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: Column(
                    children: [
                      ...state.lstProductos.entries
                          .map((e) => const Expanded(
                            child: MiTabBarwidget(
                              // tabs: [Text(e.key, style: const TextStyle(color: Colors.blue),)],
                              // tabsContent: [ListTile(title: Text(e.value.toString(), style: const TextStyle(color: Colors.black),))],
                            ),
                          ))
                          .toList()
                    ],
                  ),
                )

              ],
            ),
          ),
        );
    }
      );
  }

}

class MiTabBarwidget extends StatelessWidget {

  // final List<Widget> tabs;
  // final List<Widget> tabsContent;


  const MiTabBarwidget({
    Key? key,
    // required this.tabs,
    // required this.tabsContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productBloc = BlocProvider.of<ProductoBloc>(context);
    final lstProducts = productBloc.state.lstProductos;

    return Scaffold(
      appBar: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold,),
          unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
          indicatorWeight: 10,
          indicatorColor: Colors.green,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.all(5),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          isScrollable: true,
          physics: const BouncingScrollPhysics(),
          onTap: (int index) {
          },
          enableFeedback: true,
          tabs: lstProducts.keys
                    .map((e) => Text(e.toString()))
                    .toList(),
        ),
      body: TabBarView(
        physics: const BouncingScrollPhysics(),
        children: lstProducts.values
                    .map((e) => Text(e.toString()))
                    .toList(),
      ),
    );
  }
}