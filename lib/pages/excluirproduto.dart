import 'package:flutter/material.dart';
import 'package:estoquesimples/model/produto.dart';
import 'package:estoquesimples/database/produtodatabase.dart';

class ExcluirProduto extends StatelessWidget {
  final Produto produto;
  final VoidCallback onProdutoExcluido;

  ExcluirProduto({required this.produto, required this.onProdutoExcluido});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Excluir Produto'),
      content: Text('Deseja realmente excluir este produto?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            await _excluirProduto();
            Navigator.pop(context);
          },
          child: Text('Excluir'),
        ),
      ],
    );
  }

  Future<void> _excluirProduto() async {
    final ProdutoDatabase produtoDatabase = ProdutoDatabase();
    await produtoDatabase.delete(produto.id!); // Assumindo que o id nunca é nulo
    onProdutoExcluido();
  }
}
