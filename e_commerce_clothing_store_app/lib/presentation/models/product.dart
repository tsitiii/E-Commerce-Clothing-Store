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
}
