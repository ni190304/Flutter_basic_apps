import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/splash/splash4.dart';
import 'package:intl/intl.dart';

class FinalAppt extends StatefulWidget {
  const FinalAppt(
      {super.key,
      required this.pat_name,
      required this.weight,
      required this.height,
      required this.bmi,
      required this.app_date});

  final String pat_name;
  final String weight;
  final String height;
  final String bmi;
  final String app_date;

  @override
  State<FinalAppt> createState() => _FinalApptState();
}

final formatter = DateFormat.yMMMEd();

final now = DateTime.now();

TextStyle _getTextStyle1() {
  return GoogleFonts.cardo(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 54, 29, 29),
      fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
  );
}

TextStyle namestyle() {
  return GoogleFonts.ebGaramond(
    textStyle: const TextStyle(
      color: Color.fromARGB(255, 44, 27, 21),
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
  );
}

class _FinalApptState extends State<FinalAppt> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 5500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Splash4()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Here are your details!!!',
                style: namestyle(),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 275,
                width: 300,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 254, 237, 202),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 0.25)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Patient Name', style: _getTextStyle1()),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.pat_name,
                        style: const TextStyle(
                            fontSize: 16, color: Color.fromARGB(255, 21, 6, 2)),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Booking Date',
                        style: _getTextStyle1(),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        formatter.format(now),
                        style: const TextStyle(
                            fontSize: 16, color: Color.fromARGB(255, 21, 6, 2)),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        'Appointment date',
                        style: _getTextStyle1(),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        widget.app_date,
                        style: const TextStyle(
                            fontSize: 16, color: Color.fromARGB(255, 21, 6, 2)),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
