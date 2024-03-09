import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/user_details_input.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'Pages/Page2.dart';
import 'Pages/Page3.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

TextStyle _getTextStyle1() {
  return GoogleFonts.cardo(
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}

class _IntroPageState extends State<IntroPage> {
  final PageController pgcontroller = PageController();

  @override
  void dispose() {
    pgcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 253, 248, 248),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 575,
              child: PageView(
                controller: pgcontroller,
                children: const [
                  Page2(),
                  Page3(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SmoothPageIndicator(
              controller: pgcontroller,
              count: 2,
              effect: const WormEffect(
                  activeDotColor: Colors.deepPurpleAccent,
                  dotColor: Color.fromARGB(255, 118, 111, 111),
                  dotHeight: 7.5,
                  dotWidth: 7.5,
                  spacing: 18),
            ),
            const SizedBox(height: 35),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageTransition(
                    child: const UserInputs(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward_ios_outlined),
              label: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Next',
                  style: _getTextStyle1(),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
