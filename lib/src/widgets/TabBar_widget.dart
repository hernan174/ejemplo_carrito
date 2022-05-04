import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:app_pedidos/src/widgets/widgets.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';

  
  class TabLayout extends StatefulWidget {

    final int tabLength;

  const TabLayout({Key? key, required this.tabLength,}) : super(key: key);
    @override
    State<StatefulWidget> createState() {
      return _TabLayoutState();
    }
  
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
                  color: Colors.lightGreen,
                  height: 50,
                  width: double.infinity,
                  child: const Text(
                    'Mis Compras', 
                    style: TextStyle(fontSize:20, color: Colors.white, fontWeight: FontWeight.bold),),
                ),
                const Expanded(
                  child: MiTabBarwidget(),
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

  const MiTabBarwidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productBloc = BlocProvider.of<ProductoBloc>(context);
    final lstProducts = productBloc.state.lstProductos;

    return Scaffold(
      appBar: customTabBarWidget(lstProducts),
      body: CustomTabBarViewWidget(lstProducts: lstProducts),
    );
  }
}






  TabBar customTabBarWidget(Map<String, List<ProductoModel>> lstProducts) {
    return TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold,),
      unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
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