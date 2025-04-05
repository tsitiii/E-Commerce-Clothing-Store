import "package:flutter/material.dart";

class FeaturedProducts extends StatefulWidget {
  const FeaturedProducts({super.key});

  @override
  State<FeaturedProducts> createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.8);
  final List<Map<String, String>> _cards = [
    {

    },
    {

    },

    {
      
    }
  ];
  
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: PageView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23),
              );
            },
          ),
        ),
      ],
    );
  }
}
