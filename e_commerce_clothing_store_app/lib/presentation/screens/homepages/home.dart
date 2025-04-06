import 'package:flutter/material.dart';

import '../components/featuredProducts.dart';
import '../components/promo_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final List<Map<String, dynamic>> products = [
    {
      'image': 'images/book1.jpeg',
      'title': 'Book One',
      'price': '120 Birr',
    },
    {
      'image': 'images/book2.jpg',
      'title': 'Book Two',
      'price': '95 Birr',
    },
    {
      'image': 'images/harry.jpg',
      'title': 'Harry Potter',
      'price': '150 Birr',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: ClipOval(
                child: Image.asset(
                  'images/abiy.jpg',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                Text(
                  "User Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                enableSuggestions: true,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                  label: const Text("search here"),
                ),
              ),
              const SizedBox(height: 20),
              const PromoCarousel(),
              const SizedBox(
                height: 20,
              ),
              FeaturedProducts(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home, color: Color.fromARGB(255, 98, 64, 251))),
          BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.search, color: Colors.blueGrey)),
          BottomNavigationBarItem(
              label: 'Me', icon: Icon(Icons.shop, color: Colors.blueGrey)),
          BottomNavigationBarItem(
              label: 'Me', icon: Icon(Icons.person, color: Colors.blueGrey)),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          // if (index == 1) {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => SettingPage(
          //               onPostCreated: (imagePath, title, caption) {})));
          // } else if (index == 2) {
          //   Navigator.push(
          //       context, MaterialPageRoute(builder: (context) => MePage()));
          // } else {
          //   setState(() {
          //     currentIndex = index;
          //   });
          // }
        },
      ),
    );
  }
}
