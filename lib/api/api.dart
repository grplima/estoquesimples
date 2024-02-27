
import 'dart:convert';
import 'package:estoquesimples/api/dto/productdto.dart';
import 'package:http/http.dart' as http;

class Api {

  static Future<ProductDto> consulta(String barcode) async {
    final String token = '7UCXIZ3CDt_pEd4NFTxyyQ'; // Token da API Cosmos da Bluesoft
    final String apiUrl = 'https://api.cosmos.bluesoft.com.br/gtins/$barcode.json';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'X-Cosmos-Token': token},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return ProductDto(
        name: json['description'] ?? 'Descrição não encontrada',
        barcode: barcode,
        thumbnail: json['thumbnail'] ?? '',
        gpcCode: json['gpc'] != null ? json['gpc']['code'] ?? 'N/A' : 'N/A',
        gpcDescription: json['gpc'] != null ? json['gpc']['description'] ?? 'N/A' : 'N/A',
        fullDescription: json['full_description'] ?? 'Descrição completa não encontrada',
        ncmDescription: json['ncm'] != null ? json['ncm']['description'] ?? 'N/A' : 'N/A',
        ncmFullDescription: json['ncm'] != null ? json['ncm']['full_description'] ?? 'N/A' : 'N/A',
        brand: json['brand'] != null ? json['brand']['name'] ?? 'N/A' : 'N/A',
        validity: '', // Inicializa com vazio
        //otherPhotos: [],
      );
    } else {
      throw Exception('Falha ao obter os detalhes do produto.');
    }
  }
}