import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cartModel.dart';
import '../models/product_model.dart';
import '../repository/product_repository_impl.dart';

class CartService {
  final String baseUrl = 'https://your-api-url.com';

  Future<Cart?> fetchCartByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/carts/user/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> cartList = json.decode(response.body);
      if (cartList.isNotEmpty) {
        return Cart.fromJson(cartList[0]);
      }
    } else {
      print('Failed to load cart: ${response.statusCode}');
    }
    return null;
  }
}

Future<List<ProductModel>> fetchCartProducts(Cart cart) async {
  List<ProductModel> detailedProducts = [];
  final productRepo = ProductRepositoryImpl(client: http.Client());

  for (var cartProduct in cart.products) {
    final productEntity = await productRepo.getProductById(cartProduct.productId);
    
    detailedProducts.add(productEntity as ProductModel);
  }

  return detailedProducts;
}
