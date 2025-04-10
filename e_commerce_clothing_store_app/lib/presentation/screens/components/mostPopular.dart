import 'package:e_commerce_clothing_store_app/data/models/product_model.dart';
import 'package:e_commerce_clothing_store_app/data/repository/product_repository_impl.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/products/productList.dart';
import 'package:flutter/material.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  _MostPopularState createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  late Future<List<ProductModel>> _futureProducts;
  late List<bool> _favorites = []; // Moved to class level

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService().fetchProducts();
  }

  void _toggleFavorite(int index) {
    setState(() {
      _favorites[index] = !_favorites[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Most Popular",
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
                    MaterialPageRoute(builder: (context) => ProductListPage()),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 220,
          child: FutureBuilder<List<ProductModel>>(
            future: _futureProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Failed to load products.'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products available.'));
              }

              final products = snapshot.data!;
              // Initialize favorites list if needed
              if (_favorites.length != products.length) {
                _favorites = List.generate(products.length, (index) => false);
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];

                  return Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      right: index == products.length - 1 ? 8 : 0,
                    ),
                    child: SizedBox(
                      width: 160,
                      child: Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8)),
                                  child: Image.network(
                                    product.image,
                                    fit: BoxFit.cover,
                                    height: 120,
                                    width: double.infinity,
                                  ),
                                ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: IconButton(
                                    onPressed: () => _toggleFavorite(index),
                                    icon: Icon(
                                      _favorites[index]
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: _favorites[index]
                                          ? Colors.red
                                          : Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '\$${product.price.toString()}',
                                    style: const TextStyle(
                                        color: Colors.deepPurple, fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
