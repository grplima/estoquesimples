import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
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

  Future<void> _atualizarListaProdutos() async {
    setState(() {}); // Chama o setState para reconstruir a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Produtos'),
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
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Cadastronovo()),
          );
          // Atualiza a lista de produtos após retornar da tela de cadastro
          await _atualizarListaProdutos();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Cadastronovo extends StatelessWidget {
  final _controllergtin = TextEditingController();
  final _controllerdescricao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Novo Produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: _controllergtin,
              decoration: InputDecoration(
                labelText: 'Código GTIN',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _controllerdescricao,
              decoration: InputDecoration(
                labelText: 'Descrição do Produto',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                // Obter os valores inseridos pelo usuário
                final gtin = _controllergtin.text;
                final descricao = _controllerdescricao.text;

                // Criar um novo produto
                final novoProduto = Produto(gtin: gtin, descricao: descricao);

                // Instanciar ProdutoDatabase para acessar os métodos de banco de dados
                final produtoDatabase = ProdutoDatabase();

                // Chamar o método de inserção do ProdutoDatabase
                await produtoDatabase.insert(novoProduto);

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
    // Adicione mais inserções de amostra para outros dados
  }

  Future<void> insert(Produto produto) async {
    final Database db = await _getDatabase();
    await db.insert(
      _tableName,
      produto.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Produto>> findAll() async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return result.map((item) => Produto.fromMap(item)).toList();
  }
}