import 'package:app_pedidos/src/models/producto.dart';
import 'package:flutter/material.dart';

class ItemHomeViewWidget extends StatelessWidget {
  const ItemHomeViewWidget(
      {Key? key, required this.categoria, required this.productos})
      : super(key: key);

  final String categoria;
  final List<ProductoModel> productos;
  @override
  Widget build(BuildContext context) {
    return const ExpandCategorias();
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Panel $index',
      expandedValue: Wrap(children: const [
        Text('element1  '),
        Text('element2  '),
        Text('element3  '),
        Text('element4  '),
        Text('element5  '),
        Text('element6  '),
        Text('element7  '),
        ]),
    );
  });
}

class ExpandCategorias extends StatefulWidget {
  const ExpandCategorias({Key? key}) : super(key: key);

  @override
  State<ExpandCategorias> createState() => _ExpandCategoriasState();
}

class _ExpandCategoriasState extends State<ExpandCategorias> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: item.expandedValue,
              subtitle:
                  const Text('To delete this panel, tap the trash can icon'),
              trailing: const Icon(Icons.delete),
              onTap: () {
                setState(() {
                  _data.removeWhere((Item currentItem) => item == currentItem);
                });
              }),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
