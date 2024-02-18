import 'package:flutter/material.dart';
import 'package:estoquesimples/pages/cadastronovo.dart';
import 'package:estoquesimples/pages/visualizaproduto.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tela Inicial",
          style: TextStyle(
            color: Color(0xFFEDC71F), // Cor #EDC71F
          ),
        ),
        centerTitle: true, // Centraliza o título
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Clear_Sans2.png'), // Caminho relativo à pasta assets
            fit: BoxFit.cover,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Cadastrar Produto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Visualizar Produtos',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
          TelaInicial();
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cadastronovo()),
            );
          } else if (index == 2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VisualizaProduto()),
            );
          }
        },
      ),
    );
  }
}