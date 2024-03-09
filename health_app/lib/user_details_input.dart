import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_app/city/cities.dart';
import 'package:health_app/gender/genders.dart';
import 'package:health_app/gender/gender.dart';
import 'package:health_app/splash/splash2.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'city/city.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class UserInputs extends StatefulWidget {
  const UserInputs({Key? key}) : super(key: key);

  @override
  _UserInputsState createState() => _UserInputsState();
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

class _UserInputsState extends State<UserInputs> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numbercontroller = TextEditingController();
  final _emailController = TextEditingController();
  final _agecontroller = TextEditingController();
  final _scrollcontroller = ScrollController();

  // ignore: non_constant_identifier_names
  var selected_city = cities[Cities.mumbai]!;
  // ignore: non_constant_identifier_names
  var selected_gender = genders[Genders.male]!;

  // get nodekey => null;

  void saveDetails() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.https(
        'myhealthapp-dc787-default-rtdb.firebaseio.com',
        'user-info.json',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'personal-info': {
            'name': _nameController.text,
            'phone': _numbercontroller.text,
            'email': _emailController.text,
            'age': '${_agecontroller.text} years',
            'gender': selected_gender.title,
            'city': selected_city.title,
          },
        }),
      );

      final Map<String, dynamic> resData = jsonDecode(response.body);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => Splash2(
            
            city: selected_city.title,
            gender: selected_gender.title,
            name: _nameController.text,
            email: _emailController.text,
            phone: _numbercontroller.text,
            age: _agecontroller.text),
      )); 
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numbercontroller.dispose();
    _agecontroller.dispose();
    _scrollcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                color: const Color.fromARGB(255, 132, 63, 186),
                child: Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'lib/animations/user.json',
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 600,
                    width: 350,
                    decoration: BoxDecoration(
                        color: const Color(0xFFE6F4FF),
                        border: Border.all(
                            color: const Color(0xFFC4C4C4), width: 0.5),
                        borderRadius: BorderRadius.circular(15)),
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (notification) {
                        // ignore: unnecessary_type_check
                        if (notification is OverscrollIndicatorNotification) {
                          notification.disallowIndicator();
                        }
                        return false;
                      },
                      child: ListView(
                        padding: const EdgeInsets.all(12.5),
                        controller: _scrollcontroller,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: _nameController,
                                    maxLength: 30,
                                    autocorrect: true,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      labelText: 'Name',
                                      hintText: 'Enter your name',
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
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
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _nameController.clear();
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(
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
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _numbercontroller,
                                    maxLength: 10,
                                    autocorrect: true,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: 'Phone No',
                                      hintText: 'Enter your mobile number',
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
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
                                      prefixIcon: const Icon(Icons.phone),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _numbercontroller.clear();
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(
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
                                      if (value.length > 10) {
                                        return "Can't exceed 10 digits";
                                      }
                                      if (value.contains(' ')) {
                                        return 'Invalid Phone Number';
                                      }

                                      if (value.length != 10) {
                                        return "Phone Number must contain 10 digits";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  TextFormField(
                                    controller: _agecontroller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Age',
                                      hintText: 'Enter your age',
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
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
                                      prefixIcon:
                                          const Icon(Icons.calendar_today),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _agecontroller.clear();
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(
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
                                        return 'Invalid Age';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    maxLength: 30,
                                    autocorrect: true,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      hintText: 'Enter your email',
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
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
                                      prefixIcon:
                                          const Icon(Icons.email_rounded),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _emailController.clear();
                                        },
                                        icon: const Icon(Icons.clear),
                                      ),
                                      suffixIconConstraints:
                                          const BoxConstraints(
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
                                      if (value.contains(RegExp(r'[A-Z]'))) {
                                        return "The email shouldn't contain uppercase characters";
                                      }

                                      if (!value.contains('@gmail.com') &&
                                          !value.contains('@yahoo.co.in') &&
                                          !value.contains('@yahoo.com') &&
                                          !value.contains('@outlook.com') &&
                                          !value.contains('@hotmail.com')) {
                                        return "Invalid email";
                                      }

                                      if (value.contains(' ')) {
                                        return 'Invalid email';
                                      }

                                      if (value.length > 30) {
                                        return "Can't exceed 30 characters";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Gender',
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
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
                                      prefixIcon: Icon(selected_gender ==
                                              genders[Genders.female]
                                          ? Icons.female_rounded
                                          : Icons.male_rounded),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                    ),
                                    value: selected_gender,
                                    items: [
                                      for (final gender in genders.entries)
                                        DropdownMenuItem(
                                          value: gender.value,
                                          child: Text(gender.value.title),
                                        )
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        selected_gender = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          255, 255, 255, 255),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 14,
                                      ),
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
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
                                      prefixIcon:
                                          const Icon(Icons.location_on_sharp),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        minWidth: 40,
                                        minHeight: 40,
                                      ),
                                    ),
                                    value: selected_city,
                                    items: [
                                      for (final city in cities.entries)
                                        DropdownMenuItem(
                                          value: city.value,
                                          child: Text(city.value.title),
                                        )
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        selected_city = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      saveDetails();
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
                        ],
                      ),
                    ),
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
