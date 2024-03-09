import 'dart:async';
import 'package:shopwise/start.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class First_Screen extends StatefulWidget {
  const First_Screen({Key? key}) : super(key: key);

  @override
  State<First_Screen> createState() => _First_ScreenState();
}

TextStyle namestyle1() {
  return GoogleFonts.zeyada(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 55,
      fontWeight: FontWeight.normal,
      // fontStyle: FontStyle.italic
    ),
  );
}

TextStyle namestyle2() {
  return GoogleFonts.ebGaramond(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 239, 118, 5),
      fontSize: 30,
      fontWeight: FontWeight.normal,
      // fontStyle: FontStyle.italic
    ),
  );
}

class _First_ScreenState extends State<First_Screen> {
  double _opacityLevel = 0;
  Timer? _timer1;
  Timer? _timer2;

  @override
  void initState() {
    super.initState();

    // Start Timer 1
    _timer1 = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _opacityLevel = 1; // Increase opacity to 1 after 1 second
      });

      // Start Timer 2 after Timer 1 completes
      _timer2 = Timer(const Duration(milliseconds: 400), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Start(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    // Cancel the timers to avoid calling setState() after the widget is disposed
    _timer1?.cancel();
    _timer2?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacityLevel,
          duration: const Duration(milliseconds: 400),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.asset('lib/images/comp_name.png'),
                ),
                const SizedBox(height: 35),
                Text(
                  'Shopwise',
                  style: namestyle1(),
                ),
                Text(
                  'An Ecommerce Store',
                  style: namestyle2(),
                ),
              ]),
        ),
      ),
    );
  }
}
