import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: cadastronovo(),
  ));
}

class cadastronovo extends StatelessWidget {
  cadastronovo({super.key});

  final _controllergtin = TextEditingController();
  final _controllerdescricao = TextEditingController();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de novo produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(children: [
            Container(
              child: Expanded(
                child: TextField(
                  controller: _controllergtin,
                  decoration: const InputDecoration(
                    labelText: 'Codigo GTIN',
                    border: OutlineInputBorder(),
                    // InputBorder.none
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
            ),
            Container(
              child:
                  IconButton(onPressed: () {}, icon: Icon(Icons.photo_camera)),
            )
          ]),
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
                      // InputBorder.none
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide()),
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueGrey, width: 2),
                      ),
                    )),
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
                onPressed: () {},
                child: Text('Salvar Produto'),
              ))
            ],
          )
        ]),
      ),
    );
  }
}
