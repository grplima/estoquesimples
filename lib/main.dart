import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProdutoDatabase produtoDatabase = ProdutoDatabase();

  @override
  void initState() {
    super.initState();
    produtoDatabase.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Demo'),
      ),
      body: Center(
        child: FutureBuilder<List<Produto>>(
          future: produtoDatabase.findAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final produtos = snapshot.data;
              return ListView.builder(
                itemCount: produtos?.length,
                itemBuilder: (context, index) {
                  final produto = produtos?[index];
                  return ListTile(
                    title: Text(produto!.gtin),
                    subtitle: Text(produto.descricao),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdicionarProdutoPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AdicionarProdutoPage extends StatelessWidget {

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
                  onPressed: () {
                    // Instanciar ProdutoDatabase para acessar os métodos de banco de dados
                    final produtoDatabase = ProdutoDatabase();

                    // Obter os valores inseridos pelo usuário
                    final gtin = _controllergtin.text;
                    final descricao = _controllerdescricao.text;

                    // Criar um novo Produto
                    final novoProduto = Produto(gtin: gtin, descricao: descricao, id: null);

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
        ]),
      ),
    );
  }
}


/*
 Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Salvar Produto'),
                  ))
            ],
          )

 */


class Produto {
  final int id;
  final String gtin;
  final String descricao;

  Produto({required this.id, required this.gtin, required this.descricao});

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

  Future<List<Produto>> findAll() async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return result.map((item) => Produto.fromMap(item)).toList();
  }
}