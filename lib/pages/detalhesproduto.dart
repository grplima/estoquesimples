import 'package:flutter/material.dart';
import 'package:estoquesimples/model/produto.dart';

class DetalhesProduto extends StatelessWidget {
  final Produto produto;

  DetalhesProduto({required this.produto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF145DA0),
        title: Text(
          "Lista de Produtos",
          style: TextStyle(
            color: Color(0xFFEDC71F),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFEDC71F),),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("GTIN"),
              subtitle: Text(produto.gtin),
            ),
            ListTile(
              title: Text("Descrição"),
              subtitle: Text(produto.descricao),
            ),
            ListTile(
              title: Text("Marca"),
              subtitle: Text(produto.brand),
            ),
            ListTile(
              title: Text("Código Interno"),
              subtitle: Text(produto.gpcCode),
            ),
            ListTile(
              title: Text("Categoria"),
              subtitle: Text(produto.gpcDescription),
            ),
            ListTile(
              title: Text("Tipo"),
              subtitle: Text(produto.ncmDescription),
            ),
            ListTile(
              title: Text("Descrição Completa"),
              subtitle: Text(produto.ncmFullDescription),
            ),
            // Adicione mais informações conforme necessário
          ],
        ),
      ),
      ),
    );
  }
}


// _controllergpcCode codigo interno
// _controllergpcDescription categoria
// _controllerfullDescription descricao
// _controllerncmDescription tipo
// _controllerncmFullDescription descricao NCM
// _controllerbrand marca
// _controllervalidity validade