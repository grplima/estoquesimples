import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    home: TelaInicial(),
  ));
}

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
            image: AssetImage('assets/images/Clear_Sans.png'), // Caminho relativo à pasta assets
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
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaInicial()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cadastronovo()),
            );
          }
        },
      ),
    );
  }
}

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
                Container(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.photo_camera),
                  ),
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

class Produto {
  final int? id;
  final String gtin;
  final String descricao;

  Produto({this.id, required this.gtin, required this.descricao});

  Map<String, dynamic> toMap() {
    return {
      'produto_id': id,
      'gtin': gtin,
      'descricao': descricao,
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['produto_id'],
      gtin: map['gtin'],
      descricao: map['descricao'],
    );
  }
}

class ProdutoDatabase {
  static const String _tableName = 'produto';
  static const String _id = 'produto_id';
  static const String _gtin = 'gtin';
  static const String _descricao = 'descricao';

  static const String createTableSQL =
      'CREATE TABLE $_tableName ($_id INTEGER PRIMARY KEY AUTOINCREMENT, $_gtin TEXT, $_descricao TEXT)';

  Future<Database> _getDatabase() async {
    final String path = join(await getDatabasesPath(), 'Relatorios.db');
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute(createTableSQL);
      await _insertSampleData(db);
    }, version: 1);
  }

  Future<void> init() async {
    final Database db = await _getDatabase();
    await db.execute(createTableSQL);
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    await db.execute(
        "INSERT INTO $_tableName ($_gtin, $_descricao) VALUES ('1234567890123', 'Produto A')");
    await db.execute(
        "INSERT INTO $_tableName ($_gtin, $_descricao) VALUES ('9876543210987', 'Produto B')");
    // Add more insert statements for other sample data
  }

  Future<void> insert(Produto produto) async {
    final Database db = await _getDatabase();
    await db.insert(
      _tableName,
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
