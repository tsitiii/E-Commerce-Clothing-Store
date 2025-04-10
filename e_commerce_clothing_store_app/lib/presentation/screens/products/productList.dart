import 'package:flutter/material.dart';
import 'details.dart'; // Import the DetailsPage

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<bool> _favorites = List.generate(8, (index) => index % 2 == 1);

  // List of image paths matching the images declared in pubspec.yaml
  final List<String> _imagePaths = [
    'images/clock.jpg',
    'images/shoes.jpg',
    'images/Lg_tv.jpg',
    'images/ear_pod.jpg',
    'images/ja.jpg',
    'images/hoodie.jpg',
    'images/shirt.jpg',
    'images/long_shirt.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(
          'Product List',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two images per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: _imagePaths.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to DetailsPage when an item is tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsPage(),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(_imagePaths[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _favorites[index] = !_favorites[index];
                        });
                      },
                      child: Icon(
                        Icons.favorite,
                        color: _favorites[index] ? Colors.red : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
