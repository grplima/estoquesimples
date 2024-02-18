class Produto {
  final int? id;
  final String gtin;
  final String descricao;
//  final String thumbnail;
  final String gpcCode;
  final String gpcDescription;
  final String fullDescription;
  final String ncmDescription;
  final String ncmFullDescription;
  final String brand;
  String validity; // Validade do produto
//  final otherPhotos;

  Produto({this.id,
    required this.gtin,
    required this.descricao,
 //   required this.thumbnail,
    required this.gpcCode,
    required this.gpcDescription,
    required this.fullDescription,
    required this.ncmDescription,
    required this.ncmFullDescription,
    required this.brand,
    required this.validity,
   //required this.otherPhotos,
  });

  Map<String, dynamic> toMap() {
    return {
      'produto_id': id,
      'gtin': gtin,
      'descricao': descricao,
  //    'thumbnail': thumbnail,
      'gpcCode': gpcCode,
      'gpcDescription':gpcDescription,
      'fullDescription': fullDescription,
      'ncmDescription': ncmDescription,
      'ncmFullDescription': ncmFullDescription,
      'brand':brand,
      'validity':validity,
//     'otherPhotos':otherPhotos
    };

  }

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['produto_id'],
      gtin: map['gtin'] ?? '',
      descricao: map['descricao'] ?? '',
//      thumbnail: map['thumbnail'],
      gpcCode: map['gpcCode'] ?? '',
      gpcDescription: map['gpcDescription'] ?? '',
      fullDescription: map['fullDescription'] ?? '',
      ncmDescription: map['ncmDescription'] ?? '',
      ncmFullDescription: map['ncmFullDescription'] ?? '',
      brand: map['brand'] ?? '',
      validity: map['validity'] ?? '',
 //     otherPhotos: map['otherPhotos']
    );
  }

  Produto copyWith({String? gtin, String? descricao, String? gpcCode, String? gpcDescription, String? fullDescription, String? ncmDescription, String? ncmFulLDescription, String? brand, String? validity }) {
    return Produto(
      id: id,
      gtin: gtin ?? this.gtin,
      descricao: descricao ?? this.descricao,
 //     thumbnail: thumbnail,
      gpcCode: gpcCode ?? this.gpcCode,
      gpcDescription: gpcDescription ?? this.gpcDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      ncmDescription: ncmDescription ?? this.ncmDescription,
      ncmFullDescription: ncmFullDescription ?? this.ncmFullDescription,
      brand: brand ?? this.brand,
      validity: validity ?? this.validity,
 //     otherPhotos: otherPhotos
    );
  }
}

