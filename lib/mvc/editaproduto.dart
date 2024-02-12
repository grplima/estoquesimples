import 'package:flutter/material.dart';
import 'package:estoquesimples/mvc/produto.dart';
import 'package:estoquesimples/mvc/produtodatabase.dart';
import 'package:estoquesimples/mvc/visualizaproduto.dart';


class EditaProduto extends StatefulWidget {
  final Produto produto;
  final VoidCallback onProdutoEditado;

  EditaProduto({required this.produto, required this.onProdutoEditado});

  @override
  _EditaProdutoState createState() => _EditaProdutoState();
}

class _EditaProdutoState extends State<EditaProduto> {
  final TextEditingController _controllerGTIN = TextEditingController();
  final TextEditingController _controllerDescricao = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerGTIN.text = widget.produto.gtin;
    _controllerDescricao.text = widget.produto.descricao;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Produto"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _editarProduto();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerGTIN,
              decoration: const InputDecoration(
                labelText: 'Codigo GTIN',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 14),
            TextField(
              controller: _controllerDescricao,
              decoration: const InputDecoration(
                labelText: 'Descrição do produto',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _editarProduto() async {
    // Obter os valores atualizados
    final String novoGTIN = _controllerGTIN.text;
    final String novaDescricao = _controllerDescricao.text;

    // Criar um novo objeto Produto com os valores atualizados
    final Produto produtoAtualizado =
    widget.produto.copyWith(gtin: novoGTIN, descricao: novaDescricao);

    // Atualizar o produto no banco de dados
    final ProdutoDatabase produtoDatabase = ProdutoDatabase();
    await produtoDatabase.update(produtoAtualizado);

    // Executar a função de retorno de chamada
    widget.onProdutoEditado();

    // Voltar para a tela anterior
    Navigator.pop(context);
  }
}
