import 'package:flutter/material.dart';

class FeaturedProducts extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      'image': 'images/nike2.jpg',
      'title': 'Harry Potter',
      'price': '\$12.99',
    },
    {
      'image': 'images/jordan.jpg',
      'title': 'Atomic Habits',
      'price': '\$10.50',
    },
    {
      'image': 'images/jacket.webp',
      'title': 'The Goblet of Fire',
      'price': '\$14.20',
    },
    {
      'image': 'images/ear.jpg',
      'title': 'The Goblet of Fire',
      'price': '\$14.20',
    },
  ];

  FeaturedProducts({super.key});

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
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(
          height: 190,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            padding:
                const EdgeInsets.symmetric(horizontal: 8), 
            itemCount: products.length,
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
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
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
                          child: Image.asset(
                            product['image']!,
                            height: 100,
                            width: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['title']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                product['price']!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 102, 76, 175),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border,
                            size: 20, color: Colors.white),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
