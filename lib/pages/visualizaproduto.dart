import 'package:flutter/material.dart';
import 'package:estoquesimples/model/produto.dart';
import 'package:estoquesimples/database/produtodatabase.dart';
import 'package:estoquesimples/pages/editaproduto.dart';
import 'package:estoquesimples/pages/excluirproduto.dart';

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
            color: Color(0xFFEDC71F),
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _exibirTelaEdicao(produtos[index]);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _exibirDialogoExclusao(produtos[index]);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _exibirTelaEdicao(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditaProduto(
          produto: produto,
          onProdutoEditado: () {
            // Atualizar a lista após a edição
            _carregarProdutos();
          },
        ),
      ),
    );
  }

  void _exibirDialogoExclusao(Produto produto) {
    showDialog(
      context: context,
      builder: (context) {
        return ExcluirProduto(
          produto: produto,
          onProdutoExcluido: () {
            // Atualizar a lista após a exclusão
            _carregarProdutos();
          },
        );
      },
    );
  }
}
