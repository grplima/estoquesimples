
class ProductDto {
  final String name;
  final String barcode;
  final String thumbnail;
  final String gpcCode;
  final String gpcDescription;
  final String fullDescription;
  final String ncmDescription;
  final String ncmFullDescription;
  final String brand;
  String validity; // Validade do produto
//  List<String> otherPhotos;

  ProductDto({
    required this.name,
    required this.barcode,
    required this.thumbnail,
    required this.gpcCode,
    required this.gpcDescription,
    required this.fullDescription,
    required this.ncmDescription,
    required this.ncmFullDescription,
    required this.brand,
    required this.validity,
//    required this.otherPhotos,
  });

  @override
  String toString() {
    return 'ProductDto{name: $name, barcode: $barcode, '
        'thumbnail: $thumbnail, '
        'gpcCode: $gpcCode,'
        ' gpcDescription: $gpcDescription, '
        'fullDescription: $fullDescription, '
        'ncmDescription: $ncmDescription, '
        'ncmFullDescription: $ncmFullDescription, '
        'brand: $brand, validity: $validity, ';
        //'otherPhotos: $otherPhotos}';
  }
}