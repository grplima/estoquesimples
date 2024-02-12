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