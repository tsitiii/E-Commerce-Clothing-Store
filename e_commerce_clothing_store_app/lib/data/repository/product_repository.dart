import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/product_entity.dart';
import '../models/product_model.dart';
import '../models/product_filter.dart'; // Assuming you have this

class ProductRepository {
  final String baseUrl;
  final http.Client client;

  ProductRepository({
    required this.baseUrl,
    required this.client,
  });

  Future<List<ProductModel>> searchProducts(ProductFilter filter) async {
    try {
      final response = await client.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        List<ProductModel> products = jsonList.map((json) => 
            ProductModel.fromJson(json)).toList();

        // Apply filters based on your original ProductModel fields
        if (filter.query?.isNotEmpty ?? false) {
          final query = filter.query!.toLowerCase();
          products = products.where((product) => 
              product.title.toLowerCase().contains(query)).toList();
        }

        if (filter.category?.isNotEmpty ?? false) {
          products = products.where((product) => 
              product.category.toLowerCase() == 
              filter.category!.toLowerCase()).toList();
        }

        if (filter.minPrice != null) {
          products = products.where((product) => 
              product.price >= filter.minPrice!).toList();
        }

        if (filter.maxPrice != null) {
          products = products.where((product) => 
              product.price <= filter.maxPrice!).toList();
        }

        return products;
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Product search failed: ${e.toString()}');
    }
  }
}