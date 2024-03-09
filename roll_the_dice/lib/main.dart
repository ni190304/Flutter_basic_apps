import 'package:flutter/material.dart';
import 'package:roll_the_dice/roll.dart';

void main(){
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color.fromARGB(255, 5, 31, 54),Color.fromARGB(255, 11, 45, 73),Color.fromARGB(255, 65, 116, 157),],stops: [0.1,0.5,0.9],begin: Alignment.topLeft,end: Alignment.bottomRight)
          ),
          child: const Roll(),
          ),
        ),
        
      );
  }
}