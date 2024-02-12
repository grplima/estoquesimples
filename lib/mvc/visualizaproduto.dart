import 'package:flutter/material.dart';
import 'package:estoquesimples/mvc/produto.dart';
import 'package:estoquesimples/mvc/produtodatabase.dart';

class VisualizaProduto extends StatefulWidget {
  @override
  _VisualizaProdutoState createState() => _VisualizaProdutoState();
}

class _VisualizaProdutoState extends State<VisualizaProduto> {
  final ProdutoDatabase produtoDatabase = ProdutoDatabase();
  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  Future<void> _carregarProdutos() async {
    produtos = await produtoDatabase.getAllProdutos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de Produtos",
          style: TextStyle(
            color: Color(0xFFEDC71F), // Cor #EDC71F
          ),
        ),
        centerTitle: true,
      ),
      body: produtos.isEmpty
          ? Center(
        child: Text("Nenhum produto cadastrado."),
      )
          : ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(produtos[index].descricao),
            subtitle: Text("GTIN: ${produtos[index].gtin}"),
          );
        },
      ),
    );
  }
}
