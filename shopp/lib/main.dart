import 'package:flutter/material.dart';

import 'groc_list.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Groceries',
      theme: ThemeData.dark().copyWith(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 122, 188, 242),
              brightness: Brightness.dark,
              surface: Colors.blueGrey),
          scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60)),
      home: const Grocery_list(),
    );
  }
}
