class Product {
  int id;
  int gtin;
  String descricao;

  Product({required this.id, required this.gtin, required this.descricao});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'gtin': gtin,
      'descricao': descricao,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      gtin: map['gtin'],
      descricao: map['descricao'],
    );
  }
}
