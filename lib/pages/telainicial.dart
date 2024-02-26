import 'package:flutter/material.dart';
import 'package:estoquesimples/pages/cadastronovo.dart';
import 'package:estoquesimples/pages/visualizaproduto.dart';
import 'package:estoquesimples/pages/sobrenos.dart';

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF145DA0),
      appBar: AppBar(
        backgroundColor: Color(0xFF145DA0),
        title: Text(
          "Início",
          style: TextStyle(fontSize: 25,
            color: Color(0xFFEDC71F), // Cor #EDC71F
          ),
        ),
        centerTitle: true, // Centraliza o título
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logoVerticalTransp.png'), // Caminho relativo à pasta assets
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        unselectedFontSize: 15,
        selectedFontSize: 15,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 40, color: Colors.grey,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 40, color: Colors.grey,),
            label: 'Cadastrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, size: 40, color: Colors.grey,),
            label: 'Visualizar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, size: 40, color: Colors.grey,),
            label: 'Sobre nós',
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
          }else if (index == 3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SobreNosPage()),
            );
          }
        },
      ),
    );
  }
}