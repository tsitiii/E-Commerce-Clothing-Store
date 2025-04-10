import 'dart:async';
import 'dart:convert';
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
    final response = await client.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      List<Product> products = jsonList
          .map((json) => Product(
                id: json['id'].toString(),
                name: json['title'],
                price: (json['price'] as num).toDouble(),
                imageUrl: json['image'],
                brand: json['category'],
                gender: _extractGender(json['category']),
              ))
          .toList();

      // Apply filters
      if (filter.query != null && filter.query!.isNotEmpty) {
        products = products
            .where((product) => product.name
                .toLowerCase()
                .contains(filter.query!.toLowerCase()))
            .toList();
      }

      if (filter.gender != null) {
        products = products
            .where((product) =>
                product.gender?.toLowerCase() == filter.gender!.toLowerCase())
            .toList();
      }

      if (filter.brands.isNotEmpty) {
        products = products
            .where((product) => filter.brands.contains(product.brand))
            .toList();
      }

      // if (filter.priceRange != null) {
      //   products = products
      //       .where((product) =>
      //           product.price >= filter.priceRange.start &&
      //           product.price <= filter.priceRange.end)
      //       .toList();
      // }

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  String? _extractGender(String category) {
    category = category.toLowerCase();
    if (category.contains("men")) return "Men";
    if (category.contains("women")) return "Women";
    return null;
  }
}
