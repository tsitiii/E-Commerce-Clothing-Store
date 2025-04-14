import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/filter_params.dart';
import '../models/product_model.dart';

class ProductService {
  Future<List<ProductModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch products');
    }
  }
  
}

class ProductRepositoryImpl implements ProductRepository {

  final http.Client client;
  final String baseUrl;
  ProductRepositoryImpl({
    required this.client,
    this.baseUrl = 'https://fakestoreapi.com',
  });

  @override
  Future<List<ProductEntity>> getProducts() async {
    final response = await client.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
Future<ProductEntity> getProductById(int id) async {
  final response = await client.get(Uri.parse('$baseUrl/products/$id'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonMap = json.decode(response.body);
    return ProductModel.fromJson(jsonMap);
  } else {
    throw Exception('Failed to load product by ID');
  }
}


  @override
  Future<List<ProductEntity>> getProductsByCategory(String category) async {
    final response = await client.get(
      Uri.parse('$baseUrl/products/category/$category'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products by category');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    final response = await client.get(
      Uri.parse('$baseUrl/products/categories'),
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.cast<String>();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Future<List<ProductEntity>> searchProducts(FilterParams params) async {
    List<ProductEntity> products = await getProducts();

    if (params.query != null) {
      products = products
          .where((product) =>
              product.title.toLowerCase().contains(params.query!.toLowerCase()))
          .toList();
    }

    if (params.category != null) {
      products = products
          .where((product) => product.category == params.category)
          .toList();
    }

    if (params.minPrice != null) {
      products = products
          .where((product) => product.price >= params.minPrice!)
          .toList();
    }

    if (params.maxPrice != null) {
      products = products
          .where((product) => product.price <= params.maxPrice!)
          .toList();
    }

    return products;
  }
}
