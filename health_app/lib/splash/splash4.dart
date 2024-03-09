import 'dart:async';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Splash4 extends StatefulWidget {
  const Splash4({Key? key}) : super(key: key);

  @override
  State<Splash4> createState() => _Splash4State();
}

class _Splash4State extends State<Splash4> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 4200), () {
      exit(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Lottie.asset('lib/animations/splash4.json'),
        ),
      ),
    );
  }
}
