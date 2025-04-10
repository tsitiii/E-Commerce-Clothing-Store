import 'package:e_commerce_clothing_store_app/presentation/screens/authPages/login.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/components/mostPopular.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/featuredProducts.dart';
import '../components/promo_carousel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  String username = '';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  void loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final storedUsername = prefs.getString('username');
    final token = prefs.getString('token');
    print("stored token:$token");
    print("📦 Stored username: $storedUsername");

    setState(() {
      username = (storedUsername != null && storedUsername != 'null')
          ? storedUsername
          : 'User';
      imageUrl = prefs.getString('imageUrl') ?? '';
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: ClipOval(
                child: imageUrl.isNotEmpty && imageUrl != "null"
                    ? (imageUrl.startsWith("http")
                        ? Image.network(
                            imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ))
                    : Container(
                        color: Colors.grey[200],
                        width: 50,
                        height: 50,
                        child: const Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Hello",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                Text(
                  username,
                  style: const TextStyle(
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
              SizedBox(
                height: 60,
                child: TextFormField(
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10), // Better text alignment
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const PromoCarousel(),
              const SizedBox(height: 20),
              FeaturedProducts(),
              const SizedBox(height: 10),
              const MostPopular(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home, color: Color.fromARGB(255, 98, 64, 251)),
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.search, color: Colors.blueGrey),
          ),
          BottomNavigationBarItem(
            label: 'Shop',
            icon: Icon(Icons.shop, color: Colors.blueGrey),
          ),
          BottomNavigationBarItem(
            label: 'Me',
            icon: Icon(Icons.person, color: Colors.blueGrey),
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
