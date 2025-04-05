import 'package:flutter/material.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  final List<Map<String, String>> _cards = [
    {
      'image': '../../../../images/harry.jpg',
      'title': 'Participate and get prizes',
      'subtitle': 'Prize pool 🎁',
      'description': 'Limited time offer! Join now!',
      'cta': 'Shop Now'
    },
    {
      'image': '../../../../images/book2.jpg',
      'title': 'Enter the contest',
      'subtitle': 'Win the Cup🏆',
      'description': 'Exciting rewards await!',
      'cta': 'Enter Contest'
    },
    {
      'image': '../../../../images/book1.jpeg',
      'title': 'Special discount for winners',
      'subtitle': '205 Off',
      'description': 'For children\'s books collection',
      'cta': 'Claim Offer'
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: _cards.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Card(
                  color: const Color.fromARGB(255, 101, 23, 226),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _cards[index]['title']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _cards[index]['subtitle']!,
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _cards[index]['description']!,
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.amber,
                                  foregroundColor: Colors.black,
                                  minimumSize: const Size(100, 30),
                                ),
                                child: Text(
                                  _cards[index]['cta']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(12)),
                        child: Image.asset(
                          _cards[index]['image']!,
                          width: 100,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _cards.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? const Color.fromARGB(255, 23, 7, 255)
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
