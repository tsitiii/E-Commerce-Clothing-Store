import 'package:e_commerce_clothing_store_app/data/models/product_model.dart';
import 'package:e_commerce_clothing_store_app/data/repository/product_repository_impl.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/products/productList.dart';
import 'package:flutter/material.dart';

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key});

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  late Future<List<ProductModel>> _futureProducts;
  final List<bool> _favorites = [];

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Featured',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                child: const Text(
                  "See All",
                  style: TextStyle(
                    color: Color.fromARGB(255, 89, 33, 243),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListPage()));
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 190,
          child: FutureBuilder<List<ProductModel>>(
            future: _futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              final products = snapshot.data!;
              if (_favorites.length < products.length) {
                _favorites
                    .addAll(List.generate(products.length, (index) => false));
              }

              return GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: products.length > 5 ? 5 : products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Stack(
                    children: [
                      Container(
                        width: 160,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 243, 240, 240),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 243, 242, 242)
                                  .withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.network(
                                product.image,
                                height: 80,
                                width: 110,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    "\$${product.price.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 102, 76, 175),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 20,
                        left: 12,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black26)],
                          ),
                          child: IconButton(
                            icon: Icon(
                              _favorites[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20,
                              color:
                                  _favorites[index] ? Colors.red : Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _favorites[index] =
                                    !_favorites[index]; // Toggle favorite state
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
