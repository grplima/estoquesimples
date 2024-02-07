
import 'package:estoquesimples/dao/produto_dao.dart';
import 'package:estoquesimples/model/produto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ProdutoDaoDb implements ProdutoDao {

  final String tabela = "produto";
  Database? _db;

  @override
  Future iniciar() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'produto.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $tabela(prduto_id INTEGER PRIMARY KEY AUTOINCREMENT, gtin TEXT, desc TEXT)',
        );
      },
      version: 1,
    );
  }

  @override
  Future atualizar(Produto produto) async {
    await _db!.update(
      tabela,
      produto.toMap(),
      where: 'id = ?',
      whereArgs: [produto.produto_id],
    );
  }

  @override
  Future excluir(Produto produto) async {
    await _db!.delete(
      tabela,
      where: 'id = ?',
      whereArgs: [produto.produto_id],
    );
  }

  @override
  Future<List<Produto>> listar() async {
    final List<Map<String, dynamic>> result = await _db!.query(tabela);
    return result.map((element) => Produto.fromMap(element)).toList();
  }

  @override
  Future<Produto> salvar(Produto produto) async {
    produto.produto_id = await _db!.insert(tabela, produto.toMap());
    return produto;
  }
}