import 'package:flutter/material.dart';

class MostPopular extends StatefulWidget {
  const MostPopular({super.key});

  @override
  _MostPopularState createState() => _MostPopularState();
}

class _MostPopularState extends State<MostPopular> {
  final List<Map<String, String>> _cards = [
    {
      'image': 'images/cutehoddie.jpg',
      'title': 'Harry Potter',
      'price': '\$12.99',
    },
    {
      'image': 'images/earpod.jpg',
      'title': 'Atomic Habits',
      'price': '\$10.50',
    },
    {
      'image': 'images/green.jpg',
      'title': 'The Goblet of Fire',
      'price': '\$14.20',
    },
    {
      'image': 'images/hoodie.jpg',
      'title': 'The Goblet of Fire',
      'price': '\$14.20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Most Popular",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "See All",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 200, // Fixed height for the ListView
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _cards.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 8, right: index == _cards.length - 1 ? 8 : 0),
                child: SizedBox(
                  width: 160,
                  child: Card(
                    elevation: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(4)),
                              child: Image.asset(
                                _cards[index]['image']!,
                                fit: BoxFit.cover,
                                height: 120,
                                width: double.infinity,
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.favorite_border,
                                  color: Colors.white,
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
                                _cards[index]['title']!,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                _cards[index]['price']!,
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
          ),
        ),
      ],
    );
  }
}
