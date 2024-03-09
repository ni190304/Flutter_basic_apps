import 'package:flutter/material.dart';
// import 'package:health_app/home_page.dart';
import 'package:health_app/splash/splash1.dart';

void main() {
  runApp(const MeraApp());
}

class MeraApp extends StatelessWidget {
  const MeraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: Splash1());
  }
}
