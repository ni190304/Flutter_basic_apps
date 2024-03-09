import 'dart:async';
import 'package:health_app/home_page.dart';
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

class Splash2 extends StatefulWidget {
  const Splash2({
    Key? key,
    required this.city,
    required this.gender,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    // required this.id,
  }) : super(key: key);

  final String gender;
  final String name;
  final String email;
  final String phone;
  final String age;
  // final String id;
  final String city;

  @override
  State<Splash2> createState() => _Splash2State();
}

class _Splash2State extends State<Splash2> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 3200), () {
      Navigator.of(context).pushReplacement(PageTransition(
          child: HomePage(
              city: widget.city,
              gender: widget.gender,
              name: widget.name,
              email: widget.email,
              phone: widget.phone,
              age: widget.age,
              ),
          type: PageTransitionType.rightToLeft));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('lib/animations/splash2.json'),
      ),
    );
  }
}
