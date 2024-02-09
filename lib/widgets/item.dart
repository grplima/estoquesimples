import 'package:estoquesimples/model/produto.dart';
import 'package:flutter/material.dart';

enum MyItem { itemEdit, itemDelete, itemTap, itemLongPress }

class Item extends StatelessWidget {
  Item({super.key, required this.produto, required this.onMenuClick});

  late Function(MyItem item) onMenuClick;
  late Produto produto;

  _getPopupMenuItem(){
    return PopupMenuButton<MyItem>(

      onSelected: (MyItem value) {
        onMenuClick(value);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MyItem>>[
        const PopupMenuItem<MyItem>(
          value: MyItem.itemEdit,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Editar'),
          ),
        ),
        const PopupMenuItem<MyItem>(
          value: MyItem.itemDelete,
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Remover'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Text(produto.gtin, style: TextStyle(fontSize: 30),)),
              _getPopupMenuItem()
            ],
          ),
        ],
      ),
      //subtitle:  Text(pessoa.email),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(produto.descricao)
            ],
          ),
        ],
      ),
      onTap: () {
        onMenuClick(MyItem.itemTap);
      },
      onLongPress: () {
        onMenuClick(MyItem.itemLongPress);
      },
    );
  }
}
