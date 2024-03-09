import 'dart:async';
import 'package:health_app/intropage.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class Splash1 extends StatefulWidget {
  const Splash1({Key? key}) : super(key: key);

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 4200), () {
      Navigator.of(context).pushReplacement(PageTransition(
          child: const IntroPage(), type: PageTransitionType.rightToLeft));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('lib/animations/splash1.json'),
      ),
    );
  }
}
