// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String? brand;
  final String? gender;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.brand,
    this.gender,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image'] ?? '',
      brand: json['brand'],
      gender: json['gender'],
    );
  }
}