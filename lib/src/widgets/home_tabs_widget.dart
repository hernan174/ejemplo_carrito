import 'package:app_pedidos/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
  
  
  class TabLayoutExample extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
      return _TabLayoutExampleState();
    }
  
  }
  
  class _TabLayoutExampleState extends State<TabLayoutExample> with TickerProviderStateMixin {
  
    late TabController _tabController;
  
    @override
    void initState() {
      super.initState();
      _tabController = TabController(length: 3, vsync: this);
      _tabController.animateTo(2);
    }
  
    static const List<Tab> _tabs = [
      Tab(
        height: 15,
        child: Text('Ofertas')
        ),
      Tab(
        height: 15,
        child: Text('Categorias')
        ),
      Tab(
        height: 15,
        child: Text('Favoritos')
        ),
    ];
  
    static const List<Widget> _views = [
      Center(child: Text('Ofertas')),
      Center(child: ListadoWidget()),
      Center(child: Text('Favoritos')),
    ];
  
    @override
    Widget build(BuildContext context) {
      return DefaultTabController(
          length: 3,
          child: Expanded(
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle: const TextStyle(fontStyle: FontStyle.italic),
                  overlayColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blue;
                    } if (states.contains(MaterialState.focused)) {
                      return Colors.orange;
                    } else if (states.contains(MaterialState.hovered)) {
                      return Colors.pinkAccent;
                    }
            
                    return Colors.transparent;
                  }),
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
                    print('Tab $index is tapped');
                  },
                  enableFeedback: true,
                  tabs: _tabs,
                ),
                backgroundColor: Colors.transparent,
              ),
              body: const TabBarView(
                physics: BouncingScrollPhysics(),
                children: _views,
              ),
            ),
          ),
        );
    }
  }