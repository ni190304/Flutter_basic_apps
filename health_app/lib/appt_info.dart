import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/final_appt.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

final formatter = DateFormat.yMMMEd();

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({Key? key}) : super(key: key);

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  final _formKey = GlobalKey<FormState>();
  final _patientNameController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  double _bmi = 0;
  DateTime? selected_app_date;

  @override
  void dispose() {
    _patientNameController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  TextStyle _getTextStyle1() {
    return GoogleFonts.cardo(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 19,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text);
    final height = double.tryParse(_heightController.text);

    if (weight != null && height != null) {
      setState(() {
        _bmi = weight / ((height / 100) * (height / 100));
      });
    } else {
      setState(() {
        _bmi = 0;
      });
    }
  }

  void saveDetails() async {
    if (_formKey.currentState!.validate() && selected_app_date != null) {
      _formKey.currentState!.save();

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
            'appointment-info': {
              'patient': _patientNameController.text,
              'weight': '${_weightController.text} kg',
              'height': '${_heightController.text} cm',
              'bmi': _bmi.toStringAsFixed(2),
              'appointment_date': selected_app_date.toString(),
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
    } else {
      const snackbar = SnackBar(content: Text('Pick a suitable date'));

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void app_date_picker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = firstDate.add(const Duration(days: 15));

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: const Color.fromARGB(
                255, 32, 11, 88), 
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(255, 28, 30, 55), 
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        selected_app_date = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    void nextPage() {
      Navigator.of(context).push(PageTransition(
          child: FinalAppt(
            pat_name: _patientNameController.text,
            app_date: formatter.format(selected_app_date!),
            bmi: _bmi.toStringAsFixed(2),
            weight: _weightController.text,
            height: _heightController.text,
          ),
          type: PageTransitionType.rightToLeft));
    }

    return Scaffold(
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
          title: Text(
            'Schedule your Appointment',
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 23.0, right: 23.0),
            child: Container(
              height: 515,
              width: 350,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F4FF),
                border: Border.all(color: const Color(0xFFC4C4C4), width: 0.5),
                borderRadius: BorderRadius.circular(13),
              ),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (notification) {
                  if (notification is OverscrollIndicatorNotification) {
                    notification.disallowIndicator();
                  }
                  return false;
                },
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _patientNameController,
                            maxLength: 30,
                            autocorrect: true,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'Patient name',
                              hintText: "Enter patient's name",
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.deepPurpleAccent,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              prefixIcon: const Icon(Icons.person),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _patientNameController.clear();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Can't leave it blank";
                              }
                              if (value.length > 30) {
                                return "Can't exceed 30 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _weightController,
                            autocorrect: true,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'Your weight(in kg)',
                              hintText: 'Enter your weight',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.deepPurpleAccent,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              prefixIcon: const Icon(Icons.fitness_center),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _weightController.clear();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Can't leave it blank";
                              }
                              if (value.contains(' ')) {
                                return 'Invalid Weight';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _calculateBMI();
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _heightController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Your height(in cm)',
                              hintText: 'Enter your height',
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(255, 255, 255, 255),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.deepPurpleAccent,
                                  width: 1.5,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                              errorStyle: const TextStyle(color: Colors.red),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 1.5,
                                ),
                              ),
                              prefixIcon: const Icon(Icons.height_sharp),
                              prefixIconConstraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _heightController.clear();
                                },
                                icon: const Icon(Icons.clear),
                              ),
                              suffixIconConstraints: const BoxConstraints(
                                minWidth: 40,
                                minHeight: 40,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Can't leave it blank";
                              }
                              if (value.contains(' ')) {
                                return 'Invalid Height';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _calculateBMI();
                            },
                          ),
                          const SizedBox(height: 30),
                          Container(
                            height: 55,
                            width: 110,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 32, 11, 88),
                              border: Border.all(
                                color: const Color.fromARGB(255, 34, 5, 5),
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Your BMI',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 179, 174, 173)),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _bmi.toStringAsFixed(2),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          GestureDetector(
                            onTap: app_date_picker,
                            child: Container(
                              height: 50,
                              width: 300,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 34, 5, 5),
                                  width: 0.5,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Text(
                                      selected_app_date == null
                                          ? 'No date selected'
                                          : formatter
                                              .format(selected_app_date!),
                                      style: const TextStyle(
                                          fontSize: 17,
                                          color:
                                              Color.fromARGB(255, 78, 76, 76)),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      Icons.calendar_month_rounded,
                                      size: 25,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              saveDetails();
                              nextPage();
                            },
                            icon: const Icon(Icons.save),
                            label: Text(
                              'Save Details and continue',
                              style: _getTextStyle1(),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 6, 5, 43),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
