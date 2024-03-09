import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle t1() {
  return GoogleFonts.ebGaramond(
    fontSize: 23,
    fontWeight: FontWeight.normal,
    color: Colors.white,
  );
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ClipRRect(
        child: Container(
          color: const Color.fromARGB(255, 132, 63, 186),
          child: Column(
            children: [
              Container(
                  height: 160,
                  width: 300,
                  child: Image.asset('lib/images/logo.png')),
              Container(
                  height: 350,
                  width: 400,
                  child: Image.asset('lib/images/img2.png')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Book doctor appointments according to the disease you want to get cured",
                  style: t1(),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
