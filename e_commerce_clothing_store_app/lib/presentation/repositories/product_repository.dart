import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/product_filter.dart';

class ProductRepository {
  final String baseUrl;
  final http.Client client;

  ProductRepository({
    required this.baseUrl,
    required this.client,
  });

  Future<List<Product>> searchProducts(ProductFilter filter) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Product(
        id: '1',
        name: 'Sample Product',
        price: 99.99,
        imageUrl: 'https://example.com/image.jpg',
        brand: 'Nike',
        gender: 'Men',
      ),
    ];
  }
}
