import 'package:flutter/material.dart';
import 'package:estoquesimples/pages/cadastronovo.dart';
import 'package:estoquesimples/pages/visualizaproduto.dart';
import 'package:estoquesimples/pages/sobrenos.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF145DA0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF145DA0),
        title: const Text(
          "Início",
          style: TextStyle(
            fontSize: 25,
            color: Color(0xFFEDC71F), // Cor #EDC71F
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logoVerticalTransp.png'), // Caminho relativo à pasta assets
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(color: Colors.grey),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        unselectedFontSize: 15,
        selectedFontSize: 15,
        items: const [
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
            icon: Icon(Icons.info, size: 40, color: Colors.grey,),
            label: 'Sobre Nós',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cadastronovo()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VisualizaProduto()),
            );
          } else if (index == 3) {
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
