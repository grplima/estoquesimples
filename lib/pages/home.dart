import 'package:estoquesimples/dao/impl/produto_dao_api.dart';
import 'package:estoquesimples/dao/impl/produto_dao_db.dart';
import 'package:estoquesimples/dao/produto_dao.dart';
import 'package:estoquesimples/model/produto.dart';
import 'package:estoquesimples/pages/novo.dart';
import 'package:estoquesimples/widgets/item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Produto> _listaProduto = [];
  late ProdutoDao _produtoDao;

  bool _carregando = true;

  Produto? produtoRemovida;

  @override
  initState() {
    _produtoDao = ProdutoDaoDb();
    //_produtoDao = ProdutoDaoApi();
    _produtoDao.iniciar().then((_) async {
      _listaProduto = await _produtoDao.listar();
      _updateLista();
    }).catchError((e){
      print(e);
    });
  }

  // _updateLista(){
  //   _listaProduto.sort((a,b) {
  //     return a.gtin.toLowerCase().compareTo(b.gtin.toLowerCase());
  //   });
  //   setState(() {
  //     _carregando = false;
  //   });
  // }


  _updateLista(){
    _listaProduto.sort((a, b) {
      // Verifica se a.gtin e b.gtin não são nulos antes de chamar toLowerCase()
      final gtinA = a.gtin?.toLowerCase() ?? '';
      final gtinB = b.gtin?.toLowerCase() ?? '';

      return gtinA.compareTo(gtinB);
    });

    setState(() {
      _carregando = false;
    });
  }


  _salvar(Produto produto){
    setState(() {
      _carregando = true;
    });
    _produtoDao.salvar(produto).then((produtoSalva) {
      _listaProduto.add(produtoSalva);
      _updateLista();
    }).catchError((e){
      print(e);
    });
  }

  _editar(Produto produto,Produto produtoEditada){
    setState(() {
      _carregando = true;
    });
    _produtoDao.atualizar(produtoEditada).then((value) {
      _listaProduto.remove(produto);
      _listaProduto.add(produtoEditada);
      _updateLista();
    }).catchError((e){
      print(e);
    });
  }

  _remover(Produto produto){
    setState(() {
      _carregando = true;
    });
    _produtoDao.excluir(produto).then((value) {
      produtoRemovida = produto;
      _listaProduto.remove(produto);
      _updateLista();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Produto removido!'),
            backgroundColor: Colors.grey,
            action: SnackBarAction(
              label: 'Desfazer',
              textColor: Colors.black,
              onPressed: (){
                _salvar(produtoRemovida!);
              },
            ),
            duration: const Duration(seconds: 3),
          )
      );
    }).catchError((e){
      print(e);
    });
  }

  _clickAdd() {
    Navigator.push<Produto?>(
      context,
      MaterialPageRoute(
        builder: (context) => Novo(),
      ),
    ).then((Produto? produto) {
      if (produto != null) {
        _salvar(produto);
      }
    });
  }

  _clickEdit(Produto produto){
    Navigator.push<Produto?>(
      context,
      MaterialPageRoute(
        builder: (context) => Novo(produto: produto),
      ),
    ).then((Produto? produtoEditada) {
      if (produtoEditada != null) {
        _editar(produto, produtoEditada);
      }
    });
  }

  _clickRemover(Produto produto){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Remover?'),
        content: Text('Tem certeza que deseja remover o(a) ${produto.gtin} ?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _remover(produto);
              },
              child: Text('Remover')),
        ],
      ),
    );
  }

  _loading(){
    return Container(
      child: Center(
        child: Container(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_listaProduto);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cad Produtos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clickAdd,
        child: const Icon(Icons.add),
      ),
      body: _carregando ? _loading() : ListView.builder(
          padding: const EdgeInsets.only(top: 10.0),
          itemCount: _listaProduto.length,
          itemBuilder: (context, index) {
            Produto p = _listaProduto[index];
            return Item(
              pessoa: p,
              onMenuClick: (MyItem item) {
                switch(item){
                  case MyItem.itemTap:
                  case MyItem.itemEdit:
                    _clickEdit(p);
                    break;
                  case MyItem.itemLongPress:
                  case MyItem.itemDelete:
                    _clickRemover(p);
                    break;
                }
              },
            );
          }),
    );
  }
}
