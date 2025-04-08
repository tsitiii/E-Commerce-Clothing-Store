// import 'package:e_commerce_clothing_store_app/presentation/screens/homepages/home.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_clothing_store_app/presentation/screens/search/search_screen.dart';

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
      home: const SearchScreen(),
    );
  }
}
