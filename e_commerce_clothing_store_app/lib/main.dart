import 'package:e_commerce_clothing_store_app/presentation/screens/authPages/login.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/authPages/signup.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/homepages/home.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/products/productList.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/search/search_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/signup': (context) => const SignupPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/productList': (context) => const ProductListPage(),
        '/search': (context) => const SearchScreen(),
      },
    );
  }
}
