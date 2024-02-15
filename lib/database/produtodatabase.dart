import 'package:estoquesimples/model/produto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  Future<List<Produto>> getAllProdutos() async {
    final Database db = await _getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (index) {
      return Produto.fromMap(maps[index]);
    });
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

  Future<void> update(Produto produto) async {
    final Database db = await _getDatabase();
    await db.update(
      _tableName,
      produto.toMap(),
      where: '$_id = ?',
      whereArgs: [produto.id],
    );
  }

  Future<void> delete(int productId) async {
    final Database db = await _getDatabase();
    await db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [productId],
    );
  }
}