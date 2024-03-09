import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

List<String> business_emails = [];

class _InfoState extends State<Info> {
  var _isBusiness_selected = true;
  var button_pressed = false;

  var _iscont = false;

  void submit_details() async {
    setState(() {
      button_pressed = true;
    });

    final current_email = FirebaseAuth.instance.currentUser!.email;
    if (_isBusiness_selected) {
      await FirebaseFirestore.instance
          .collection('Business')
          .doc(current_email)
          .set({'email': current_email});

      print(business_emails);
    } else {
      await FirebaseFirestore.instance
          .collection('Customer')
          .doc(current_email)
          .set({'email': current_email});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Who are you ?',
              style: TextStyle(
                  fontSize: 25, color: Color.fromARGB(255, 35, 20, 15)),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(
              margin: const EdgeInsets.all(30),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isBusiness_selected = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: _isBusiness_selected 
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Businessman',
                            style: TextStyle(
                                color: _isBusiness_selected
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isBusiness_selected = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          left: 22,
                          right: 22,
                          top: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          color: _isBusiness_selected
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Customer',
                            style: TextStyle(
                                color: _isBusiness_selected
                                    ? Colors.black
                                    : Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (!button_pressed)
              ElevatedButton.icon(
                onPressed: submit_details,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 61, 24, 12),
                ),
                icon: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.white,
                  ),
                ),
                label: const Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Text(
                    'Continue',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (button_pressed) const CircularProgressIndicator()
          ],
        )),
      ),
    );
  }
}
