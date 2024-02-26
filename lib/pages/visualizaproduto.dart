import 'package:flutter/material.dart';
import 'package:estoquesimples/model/produto.dart';
import 'package:estoquesimples/database/produtodatabase.dart';
import 'package:estoquesimples/pages/editaproduto.dart';
import 'package:estoquesimples/pages/excluirproduto.dart';
import 'package:intl/intl.dart';

import 'detalhesproduto.dart';


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

  void _exibirDetalhesProduto(Produto produto) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesProduto(produto: produto),
      ),
    );
  }

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
      body: produtos.isEmpty
          ? Center(
        child: Text("Nenhum produto cadastrado."),
      )
          : ListView.builder(
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(produtos[index].descricao),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("GTIN: ${produtos[index].gtin}"),
                SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black), // Adiciona uma borda apenas para este Container
                    borderRadius: BorderRadius.all(Radius.circular(8.0)), // Opcional: Adiciona bordas arredondadas
                  ),
                  padding: EdgeInsets.all(8.0), // Adiciona espaçamento interno
                  child: Text(
                    "Dias para vencer: ${produtos[index].diasDeDiferenca()} dias",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),

            onTap: () {
              _exibirDetalhesProduto(produtos[index]);
            },

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
