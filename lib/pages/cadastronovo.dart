import 'dart:convert';
import 'package:estoquesimples/api/api.dart';
import 'package:estoquesimples/api/dto/productdto.dart';
import 'package:estoquesimples/database/produtodatabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:estoquesimples/model/produto.dart';
import 'package:intl/intl.dart';


class Product {
  final String name;
  final String barcode;
 // final String? thumbnail; // tornando thumbnail opcional
  final String gpcCode;
  final String gpcDescription;
  final String fullDescription;
  final String ncmDescription;
  final String ncmFullDescription;
  final String brand;
  final String validity;

  Product({
    required this.name,
    required this.barcode,
    required this.gpcCode,
  //  this.thumbnail,
    required this.gpcDescription,
    required this.fullDescription,
    required this.ncmDescription,
    required this.ncmFullDescription,
    required this.brand,
    required this.validity,
//    required List<dynamic> otherPhotos, // tornando thumbnail opcional
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
//  final _controllerthumbnail = TextEditingController();
  final _controllergpcCode = TextEditingController();
  final _controllergpcDescription = TextEditingController();
  final _controllerfullDescription = TextEditingController();
  final _controllerncmDescription = TextEditingController();
  final _controllerncmFullDescription = TextEditingController();
  final _controllerbrand = TextEditingController();
  final _controllervalidity = TextEditingController();
//  final _controllerotherPhotos = TextEditingController();

   String? _produtoDescricao;
  // String? _produtoTumbnail;
  // String? _produtoGpcDescription;
  // String? _produtoncmDescription;
  // String? _produtobrand;
  // String? _produtovalidity;

  bool _carregando = false;
  String _message = "";

  ProdutoDatabase _produtoDatabase = ProdutoDatabase();

  _clickBuscar() async {
    String barcode = _controllergtin.text;
    setState(() {
      _carregando = true;
    });

    // Verifica se o código de barras é o específico que você está procurando
    if (barcode == "7891037002449") {
      setState(() {
        _carregando = true;
      });

      await Future.delayed(Duration(seconds: 1));

      // Valores predefinidos
      ProductDto predefinido = ProductDto(
        name: 'DESODORANTE.SPRAY REXONA ACTIVE',
        barcode: '7891037002449',
        gpcCode: '10000346',
        gpcDescription: 'Cabelo - Condicionador / tratamento',
        fullDescription: 'REXONA ACTIVE',
        ncmDescription: 'Outras',
        ncmFullDescription: 'Óleos essenciais e resinóides; produtos de perfumaria',
        brand: 'Rexona',
        // Você pode modificar esse valor conforme necessário
        validity: '25/06/2025',
      );

      setState(() {
        _produtoDescricao = predefinido.name; // Atualize _produtoDescricao
        _controllerdescricao.text = predefinido.name;

        //_produtoTumbnail = productDto.thumbnail;
        // _controllerthumbnail.text = productDto.thumbnail;

        //_produtoGpcDescription = productDto.gpcDescription;
        _controllergpcDescription.text = predefinido.gpcDescription;
        _controllergpcCode.text = predefinido.gpcCode;
        _controllerfullDescription.text = predefinido.fullDescription;


        //_produtoncmDescription = productDto.ncmDescription;
        _controllerncmDescription.text = predefinido.ncmDescription;
        _controllerncmFullDescription.text = predefinido.ncmFullDescription;

        //_produtobrand = productDto.brand;
        _controllerbrand.text = predefinido.brand;

        //_produtovalidity = productDto.validity;
        _controllervalidity.text = predefinido.validity;

        _carregando = false;


      });

    }

    if (barcode == "7622300990732") {
      setState(() {
        _carregando = true;
      });

      await Future.delayed(Duration(seconds: 1));

      // Valores predefinidos
      ProductDto predefinido = ProductDto(
        name: 'BISC SALG CLUB SOCIAL ORIGINAL 288G',
        barcode: '7622300990732',
        gpcCode: '19059020',
        gpcDescription: 'Bolacha',
        fullDescription: 'Descrição completa não encontrada',
        ncmDescription: 'Outras',
        ncmFullDescription: 'Preparações à base de cereais, farinhas, amidos, féculas ou de leite;',
        brand: 'Club Social',
        // Você pode modificar esse valor conforme necessário
        validity: '25/04/2025',
      );

      setState(() {
        _produtoDescricao = predefinido.name; // Atualize _produtoDescricao
        _controllerdescricao.text = predefinido.name;

        //_produtoTumbnail = productDto.thumbnail;
        // _controllerthumbnail.text = productDto.thumbnail;

        //_produtoGpcDescription = productDto.gpcDescription;
        _controllergpcDescription.text = predefinido.gpcDescription;
        _controllergpcCode.text = predefinido.gpcCode;
        _controllerfullDescription.text = predefinido.fullDescription;


        //_produtoncmDescription = productDto.ncmDescription;
        _controllerncmDescription.text = predefinido.ncmDescription;
        _controllerncmFullDescription.text = predefinido.ncmFullDescription;

        //_produtobrand = productDto.brand;
        _controllerbrand.text = predefinido.brand;

        //_produtovalidity = productDto.validity;
        _controllervalidity.text = predefinido.validity;


        _carregando = false;


      });

    }


    Api.consulta(barcode).then((productDto) {
      print(productDto); // Verifique o productDto recebido da API

      setState(() {
        _produtoDescricao = productDto.name; // Atualize _produtoDescricao
        _controllerdescricao.text = productDto.name;

        //_produtoTumbnail = productDto.thumbnail;
       // _controllerthumbnail.text = productDto.thumbnail;

        //_produtoGpcDescription = productDto.gpcDescription;
        _controllergpcDescription.text = productDto.gpcDescription;
        _controllergpcCode.text = productDto.gpcCode;
        _controllerfullDescription.text = productDto.fullDescription;


        //_produtoncmDescription = productDto.ncmDescription;
        _controllerncmDescription.text = productDto.ncmDescription;
        _controllerncmFullDescription.text = productDto.ncmFullDescription;

        //_produtobrand = productDto.brand;
        _controllerbrand.text = productDto.brand;

        //_produtovalidity = productDto.validity;
        _controllervalidity.text = productDto.validity;

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


  _clickSalvar() {
    String gtin = _controllergtin.text;
    String descricao = _controllerdescricao.text;
    //String thumbnail = _controllerthumbnail.text;
    String gpcCode = _controllergpcCode.text;
    String gpcDescription = _controllergpcDescription.text;
    String fullDescription = _controllerfullDescription.text;
    String ncmDescription = _controllerncmDescription.text;
    String ncmFullDescription = _controllerncmFullDescription.text;
    String brand = _controllerbrand.text;
    String validity = _controllervalidity.text;
    //String otherPhotos = _controllerotherPhotos.text;

    DateTime validityDateTime;

    try {
      validityDateTime = DateFormat('dd/MM/yyyy').parse(validity);
    } catch (e) {
      print('Erro ao converter a data de validade para DateTime: $e');
      return;
    }

    if (gtin.isNotEmpty && descricao.isNotEmpty) {
      _produtoDatabase.insert(Produto(
        gtin: gtin,
        descricao: descricao,
        //thumbnail: thumbnail,
        gpcCode: gpcCode,
        gpcDescription: gpcDescription,
        fullDescription: fullDescription,
        ncmDescription: ncmDescription,
        ncmFullDescription: ncmFullDescription,
        brand: brand,
        validity: validity,
        //otherPhotos: otherPhotos,
      ));

      // Limpe os campos após salvar
      _controllergtin.clear();
      _controllerdescricao.clear();
      //_controllerthumbnail.clear();
      _controllergpcCode.clear();
      _controllergpcDescription.clear();
      _controllerfullDescription.clear();
      _controllerncmDescription.clear();
      _controllerncmFullDescription.clear();
      _controllerbrand.clear();
      _controllervalidity.clear();
      //_controllerotherPhotos.clear();


      // Adicione lógica adicional conforme necessário
    } else {
      // Adicione lógica de tratamento para campos vazios
    }
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
        child: SingleChildScrollView(
          child: Column(
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
              if (_produtoDescricao != null)
                Text(
                  _produtoDescricao!,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
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
                height: 8,
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !_carregando,
                      controller: _controllerbrand,
                      decoration: InputDecoration(
                        labelText: 'Marca',
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
                height: 8,
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !_carregando,
                      controller: _controllergpcCode,
                      decoration: InputDecoration(
                        labelText: 'Codigo Interno',
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
          
              // Row(
              //   children: [
              //     Expanded(
              //       child: TextField(
              //         enabled: !_carregando,
              //         controller: _controllerthumbnail,
              //         decoration: InputDecoration(
              //           labelText: 'Thumbnail',
              //           border: OutlineInputBorder(),
              //           enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
              //           labelStyle: TextStyle(
              //             fontSize: 18,
              //             color: Colors.black54,
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(color: Colors.blueGrey, width: 2),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: 8,
              ),
          
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !_carregando,
                      controller: _controllergpcDescription,
                      decoration: InputDecoration(
                        labelText: 'Categoria',
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
                height: 8,
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !_carregando,
                      controller: _controllerfullDescription,
                      decoration: InputDecoration(
                        labelText: 'Descricao',
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
                height: 8,
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !_carregando,
                      controller: _controllerncmDescription,
                      decoration: InputDecoration(
                        labelText: 'Tipo',
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
                height: 8,
              ),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !_carregando,
                      controller: _controllerncmFullDescription,
                      decoration: InputDecoration(
                        labelText: 'Descricao NCM',
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
                height: 8,
              ),


              Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !_carregando,
                      controller: _controllervalidity,
                      decoration: InputDecoration(
                        labelText: 'Validade',
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
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null && pickedDate != DateTime.now()) {
                          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
                          _controllervalidity.text = formattedDate;
                        }
                      },
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
                      onPressed: _clickSalvar,
                      child: Text('Salvar'),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

