class Produto {

  int? produto_id;
  late String? gtin;
  late String? descricao;

  Produto(
      {required this.produto_id,
        required this.gtin,
        required this.descricao,});

  Map<String, dynamic> toMap() {
    return {
      'produto_id': produto_id,
      'gtin': gtin,
      'descricao': descricao
    };
  }

  static Produto fromMap(Map<String, dynamic> map) {
    return Produto(
      produto_id: map['produto_id'],
      gtin: map['gtin'],
      descricao: map['descricao']
    );
  }

  @override
  String toString() {
    return "Produto(produto_id=$produto_id, gtin=$gtin, descricao=$descricao)";
  }
}
