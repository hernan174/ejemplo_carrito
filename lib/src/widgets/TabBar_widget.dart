import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_pedidos/src/models/producto.dart';
import 'package:app_pedidos/src/bloc/blocs.dart';

  
  class TabLayout extends StatefulWidget {

  const TabLayout({Key? key,}) : super(key: key);



    @override
    State<StatefulWidget> createState() {
      return _TabLayoutState();
    }
  
  }
  
  class _TabLayoutState extends State<TabLayout> with TickerProviderStateMixin {

    late TabController _tabController;
  
    @override
    void initState() {
      super.initState();
      context.read<ProductoBloc>().add(OnObtieneProductos());
      _tabController = TabController(length: 10, vsync: this);
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
          context.read<NavBloc>().add(GetScreen('Home'));
        });
      },
      builder: (context, state) {

      return DefaultTabController(
          length: state.lstProductos.length,
          child: SafeArea(
            child: Scaffold(
              appBar: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
                  indicatorWeight: 10,
                  indicatorColor: Colors.red,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(5),
                  indicator: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pinkAccent,
                  ),
                  isScrollable: true,
                  physics: const BouncingScrollPhysics(),
                  onTap: (int index) {
                  },
                  enableFeedback: true,
                  tabs: state.lstProductos.entries
                        .map((e) => Text(e.key))
                        .toList()
                ),
              body: TabBarView(
                physics: BouncingScrollPhysics(),
                children: state.lstProductos.entries
                        .map((e) => Center(child: Text(e.key)))
                        .toList(),
              ),
            ),
          ),
        );
    }
      );
  }
    
    
    static const List<Tab> _tabs = [
      Tab(icon: Icon(Icons.looks_one), child: Text('Tab 1')),
      Tab(icon: Icon(Icons.looks_two), text: 'Tab 2'),
      Tab(icon: Icon(Icons.looks_3), text: 'Tab 3'),
      Tab(icon: Icon(Icons.looks_4), text: 'Tab 4'),
      Tab(icon: Icon(Icons.looks_5), text: 'Tab 5'),
      Tab(icon: Icon(Icons.looks_6), text: 'Tab 6'),
    ];
  
    static const List<Widget> _views = [
      Center(child: Text('Tab 1')),
      Center(child: Text('Tab 2')),
      Center(child: Text('Tab 3')),
      Center(child: Text('Tab 4')),
      Center(child: Text('Tab 5')),
      Center(child: Text('Tab 6')),
    ];
  }