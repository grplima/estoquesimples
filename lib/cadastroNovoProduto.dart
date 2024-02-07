import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: cadastronovo(),
  ));
}

class cadastronovo extends StatelessWidget {
  cadastronovo({super.key});

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Column(children: [
        Row(children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Codigo GTIN',
                border: OutlineInputBorder(), // InputBorder.none
                enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
                labelStyle: TextStyle(
                  fontSize: 40,
                  color: Color(0xff00d7f3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff00d7f3), width: 2),
                ),
              ),
            ),
          )
        ]),
        Row(),
        Row()
      ]),
    );
  }
}
