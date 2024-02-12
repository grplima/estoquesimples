import 'package:estoquesimples/mvc/produto.dart';
import 'package:estoquesimples/mvc/produtodatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Cadastronovo extends StatelessWidget {
  Cadastronovo({Key? key}) : super(key: key);

  final _controllergtin = TextEditingController();
  final _controllerdescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro de novo produto",
          style: TextStyle(
            color: Color(0xFFEDC71F), // Cor #EDC71F
          ),
        ),
        centerTitle: true, // Centraliza o título
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retorna para a tela anterior (TelaInicial)
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centralizar verticalmente
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllergtin,
                    decoration: const InputDecoration(
                      labelText: 'Codigo GTIN',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancelar', true, ScanMode.BARCODE,
                    );

                    if (barcodeScanRes != '-1') {
                      _controllergtin.text = barcodeScanRes;
                    }
                  },
                  icon: Icon(Icons.photo_camera),
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerdescricao,
                    decoration: InputDecoration(
                      labelText: 'Descrição do produto',
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Instanciar ProdutoDatabase para acessar os métodos de banco de dados
                      final produtoDatabase = ProdutoDatabase();

                      // Obter os valores inseridos pelo usuário
                      final gtin = _controllergtin.text;
                      final descricao = _controllerdescricao.text;

                      // Criar um novo Produto
                      final novoProduto = Produto(gtin: gtin, descricao: descricao);

                      // Chamar o método de inserção do ProdutoDatabase
                      produtoDatabase.insert(novoProduto);

                      // Limpar os campos de texto após a inserção
                      _controllergtin.clear();
                      _controllerdescricao.clear();

                      // Exibir um snackbar informando que o produto foi salvo
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Produto salvo com sucesso!'),
                        ),
                      );
                    },
                    child: Text('Salvar Produto'),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
