import 'package:flutter/material.dart';
import 'package:estoquesimples/model/produto.dart';
import 'package:estoquesimples/database/produtodatabase.dart';


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
  final TextEditingController _controllergpcCode = TextEditingController();
  final TextEditingController _controllergpcDescription = TextEditingController();
  final TextEditingController _controllerfullDescription = TextEditingController();
  final TextEditingController _controllerncmDescription = TextEditingController();
  final TextEditingController _controllerncmFullDescription = TextEditingController();
  final TextEditingController _controllerbrand = TextEditingController();
  final TextEditingController _controllervalidity = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerGTIN.text = widget.produto.gtin;
    _controllerDescricao.text = widget.produto.descricao;
    _controllergpcCode.text = widget.produto.gpcCode;
    _controllergpcDescription.text = widget.produto.gpcDescription;
    _controllerfullDescription.text = widget.produto.fullDescription;
    _controllerncmDescription.text = widget.produto.ncmDescription;
    _controllerncmFullDescription.text = widget.produto.ncmFullDescription;
    _controllerbrand.text = widget.produto.brand;
    _controllervalidity.text = widget.produto.validity;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
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
            TextField(
              controller: _controllergpcCode,
              decoration: const InputDecoration(
                labelText: 'gpcCode',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _controllergpcDescription,
              decoration: const InputDecoration(
                labelText: 'gpcDescription',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _controllerfullDescription,
              decoration: const InputDecoration(
                labelText: 'fullDescription',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _controllerncmDescription,
              decoration: const InputDecoration(
                labelText: 'ncmDescription',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _controllerncmFullDescription,
              decoration: const InputDecoration(
                labelText: 'ncmFullDescription',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _controllerbrand,
              decoration: const InputDecoration(
                labelText: 'brand',
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: _controllervalidity,
              decoration: const InputDecoration(
                labelText: 'validity',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _editarProduto();
              },
              child: Text("Salvar"),
            ),
          ],
        ),
        ),
      ),
    );
  }

  void _editarProduto() async {
    // Obter os valores atualizados
    final String novoGTIN = _controllerGTIN.text;
    final String novaDescricao = _controllerDescricao.text;
    final String novagpcCode = _controllergpcCode.text;
    final String novagpcDescription = _controllergpcDescription.text;
    final String novafullDescription = _controllerfullDescription.text;
    final String novancmDescription = _controllerncmDescription.text;
    final String novancmFUllDescription = _controllerncmFullDescription.text;
    final String novabrand = _controllerbrand.text;
    final String novavalidity = _controllervalidity.text;

    // Criar um novo objeto Produto com os valores atualizados
    final Produto produtoAtualizado =
    widget.produto.copyWith(gtin: novoGTIN,
        descricao: novaDescricao,
        gpcCode: novagpcCode,
        gpcDescription: novagpcDescription,
        fullDescription: novafullDescription,
        ncmDescription: novancmDescription,
        ncmFulLDescription: novancmFUllDescription,
        brand: novabrand,
        validity: novavalidity
        );

    // Atualizar o produto no banco de dados
    final ProdutoDatabase produtoDatabase = ProdutoDatabase();
    await produtoDatabase.update(produtoAtualizado);

    // Executar a função de retorno de chamada
    widget.onProdutoEditado();

    // Voltar para a tela anterior
    Navigator.pop(context);
  }
}
