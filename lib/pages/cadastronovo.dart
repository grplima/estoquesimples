import 'dart:convert';
import 'package:estoquesimples/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Product {
  final String name;
  final String barcode;
  final String? thumbnail; // tornando thumbnail opcional

  Product({
    required this.name,
    required this.barcode,
    this.thumbnail, required String validity, required List<dynamic> otherPhotos, // tornando thumbnail opcional
  });
}
class Cadastronovo extends StatefulWidget {
  Cadastronovo({Key? key}) : super(key: key);

  @override
  _CadastronovoState createState() => _CadastronovoState();
}

class _CadastronovoState extends State<Cadastronovo> {
  final _controllergtin = TextEditingController();
  final _controllerdescricao = TextEditingController();
  String? _produtoDescricao;

  bool _carregando = false;
  String _message = "";

  _clickBuscar(){
    String barcode = _controllergtin.text;
    setState(() {
      _carregando = true;
    });
    Api.consulta(barcode).then((productDto) {
        print(productDto);
        _controllerdescricao.text = productDto.name;
        setState(() {
          _carregando = false;
        });
    }).catchError((e) {
      try {
        _message = e.toString().split('Exception: ')[1];
      } catch (e) {
        _message = "Falhou";
      }
      setState(() {
        _carregando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastro de novo produto",
          style: TextStyle(
            color: Color(0xFFEDC71F),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                ), SizedBox(width:15,),
                IconButton(onPressed: _clickBuscar, icon: Icon(Icons.search)),
                IconButton(
                  onPressed: () async {
                    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                      '#ff6666', 'Cancelar', true, ScanMode.BARCODE,
                    );

                    if (barcodeScanRes != '-1') {
                      _controllergtin.text = barcodeScanRes;
                      _clickBuscar();
                    }
                  },
                  icon: Icon(Icons.photo_camera),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20,
                    width: _message.isEmpty ? 20 : null,
                    child: _carregando ? CircularProgressIndicator() : (_message.isNotEmpty ? Text(_message) : null),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            if (_produtoDescricao != null)
              Text(
                _produtoDescricao!,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: !_carregando,
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
                    onPressed: (){},
                    child: Text('Salvar'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

