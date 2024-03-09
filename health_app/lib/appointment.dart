import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/splash/splash3.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class Appointment extends StatefulWidget {
  const Appointment({
    Key? key,
    required this.doc_name,
    required this.doc_img,
    required this.doc_desc,
    required this.doc_spec,
    required this.doc_fees,
  }) : super(key: key);

  final String doc_name;
  final String doc_desc;
  final String doc_img;
  final String doc_spec;
  final String doc_fees;

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  void bookappt() async {
    final url = Uri.https(
      'myhealthapp-dc787-default-rtdb.firebaseio.com',
      'user-info.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Iterate over all nodes and update the data
      data.forEach((key, value) async {
        // Prepare the updated data
        Map<String, dynamic> updatedData = {
          ...value, // Copy the existing data
          'doctor-info': {
            'doctor': widget.doc_name,
            'fees': '₹${widget.doc_fees}',
          },
        };

        // Construct the URL for the specific node
        final nodeUrl = Uri.https(
          'myhealthapp-dc787-default-rtdb.firebaseio.com',
          'user-info/$key.json',
        );

        // Make the PUT request to update the data for each node
        final updatedResponse = await http.put(
          nodeUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(updatedData),
        );

        if (updatedResponse.statusCode == 200) {
          print(
              'Doctor and fees information updated successfully for node $key');
        } else {
          print(
              'Failed to update doctor and fees information for node $key. Status code: ${updatedResponse.statusCode}');
        }
      });
    } else {
      print(
          'Error retrieving data from the database. Status code: ${response.statusCode}');
    }

    Navigator.of(context).pushReplacement(PageTransition(
        child: const Splash3(), type: PageTransitionType.rightToLeft));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 239, 239),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 4, 0, 0),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          splashColor: Colors.transparent,
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 19.0),
          child: Text(
            'Book an Appointment',
            style: GoogleFonts.cardo(
              textStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          if (notification is OverscrollIndicatorNotification) {
            notification.disallowIndicator();
          }
          return false;
        },
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  color: const Color.fromARGB(255, 243, 239, 239),
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    widget.doc_img,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.doc_name,
                  style: GoogleFonts.ebGaramond(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 39, 30, 28),
                      fontSize: 30.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.doc_spec,
                  style: GoogleFonts.cardo(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 78, 17, 17),
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  height: 4,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      widget.doc_desc,
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 59, 45, 39),
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 4,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 49, 27, 14),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total fees per session',
                    style: GoogleFonts.cardo(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 233, 228, 223),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '₹${widget.doc_fees}',
                    style: GoogleFonts.katibeh(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 230, 224, 224),
                        fontSize: 26.0,
                      ),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onTap: () => bookappt(),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 100, 234, 107),
                    border: Border.all(
                        color: Color.fromARGB(255, 34, 5, 5), width: 0.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Proceed',
                        style: TextStyle(
                            color: Color.fromARGB(255, 38, 24, 7),
                            fontSize: 15),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color.fromARGB(255, 18, 2, 2),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
