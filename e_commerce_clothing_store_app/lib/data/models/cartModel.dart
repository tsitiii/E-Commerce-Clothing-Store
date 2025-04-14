class CartProduct {
  final int productId;
  final int quantity;

  CartProduct({required this.productId, required this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}

class Cart {
  final int id;
  final int userId;
  final List<CartProduct> products;

  Cart({required this.id, required this.userId, required this.products});

  factory Cart.fromJson(Map<String, dynamic> json) {
    var productsList = <CartProduct>[];
    if (json['products'] != null) {
      productsList = List<CartProduct>.from(
        json['products'].map((p) => CartProduct.fromJson(p)),
      );
    }

    return Cart(
      id: json['id'],
      userId: json['userId'],
      products: productsList,
    );
  }
}
