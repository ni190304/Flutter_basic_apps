import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shopwise/business_scr.dart';
import 'package:shopwise/customer_scr.dart';
import 'package:shopwise/main_scr.dart';
import 'package:shopwise/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'auth.dart';
import 'info.dart';

class Start extends StatefulWidget {
  const Start({
    super.key,
  });

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  bool isConnected = true;

  // StreamController<bool> _uploadStatusStream = StreamController<bool>();

  @override
  void initState() {
    super.initState();
    isInternetConnected();
  }

  Future<void> isInternetConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      isConnected = (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      // Stream that listens for changes in internet connection
      stream:
          Connectivity().onConnectivityChanged.map((ConnectivityResult result) {
        return (result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi);
      }),
      initialData: true, // Initial data is set to true (connected) by default
      builder: (context, snapshot) {
        final bool isInternetConnected = snapshot.data ?? false;
        if (isInternetConnected) {
          // Connected to the internet, show the normal app UI
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.from(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(159, 6, 13, 30),
              ),
            ),
            title: 'Shopwise',
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, authSnapshot) {
                if (authSnapshot.hasData && authSnapshot.data != null) {
                  final currentEmail = authSnapshot.data!.email;
                  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('Business')
                        .doc(currentEmail)
                        .snapshots(),
                    builder: (context, busSnapshot) {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Customer')
                            .doc(currentEmail)
                            .snapshots(),
                        builder: (context, custSnapshot) {
                          if (authSnapshot.connectionState ==
                                  ConnectionState.waiting ||
                              busSnapshot.connectionState ==
                                  ConnectionState.waiting ||
                              custSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return const Splash();
                          }

                          if (authSnapshot.connectionState ==
                              ConnectionState.active) {
                            if (authSnapshot.hasData) {
                              if (busSnapshot.connectionState ==
                                      ConnectionState.active &&
                                  busSnapshot.hasData &&
                                  busSnapshot.data!.exists) {
                                return const BusinessScreen();
                              } else if (custSnapshot.connectionState ==
                                      ConnectionState.active &&
                                  custSnapshot.hasData &&
                                  custSnapshot.data!.exists) {
                                return CustomerScreen();
                              } else {
                                // If both Business and Customer documents don't exist
                                return const Info();
                              }
                            } else {
                              // User is not authenticated
                              return const AuthScreen();
                            }
                          }

                          return const Splash();
                        },
                      );
                    },
                  );
                } else {
                  // User is not authenticated or image not uploaded
                  return const AuthScreen();
                }
              },
            ),
          );
        } else {
          // Not connected to the internet, show a message or a different UI
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: SizedBox(
                  height: 300,
                  width: 250,
                  child: Lottie.asset('lib/animations/internet.json'),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
