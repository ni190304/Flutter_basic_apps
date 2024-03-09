import 'dart:async';
import 'package:health_app/appt_info.dart';
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

class Splash3 extends StatefulWidget {
  const Splash3({
    Key? key,
  }) : super(key: key);

  @override
  State<Splash3> createState() => _Splash3State();
}

class _Splash3State extends State<Splash3> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 3200), () {
      Navigator.of(context).pushReplacement(PageTransition(
          child: const AppointmentDetails(),
          type: PageTransitionType.rightToLeft));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('lib/animations/splash3.json'),
      ),
    );
  }
}
