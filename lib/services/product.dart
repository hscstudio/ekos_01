import 'dart:async';
import 'dart:convert';

import 'package:ekos_01/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  List<ProductModel> parseProducts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<ProductModel> products = parsed
        .map<ProductModel>((json) => ProductModel.fromJson(json))
        .toList();
    return products;
  }

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://60b7338a17d1dc0017b8947a.mockapi.io/api/v1/products'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseProducts(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Unable to fetch products from the REST API');
    }
  }
}
