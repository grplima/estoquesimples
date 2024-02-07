
import 'package:estoquesimples/model/produto.dart';

abstract class ProdutoDao {

  Future iniciar();
  Future<Produto> salvar(Produto produto);
  Future excluir(Produto produto);
  Future atualizar(Produto produto);
  Future<List<Produto>> listar();

}