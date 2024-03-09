import 'dart:io';
import 'package:chatapp/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var is_Login = true;

  var entered_email = '';
  var entered_pass = '';
  var entered_username = '';
  var _isAuthenticating = false;

  File? _selectedimage;

  final _formkey = GlobalKey<FormState>();

  void _submit() async {
    final is_valid = _formkey.currentState!.validate();

    if (!is_valid || !is_Login && _selectedimage == null) {
      return;
    }
    _formkey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (is_Login) {
        final UserCred = await _firebase.signInWithEmailAndPassword(
            email: entered_email, password: entered_pass);
        print(UserCred);
      } else {
        final UserCred = await _firebase.createUserWithEmailAndPassword(
            email: entered_email, password: entered_pass);
        print(UserCred);

        final storage_ref = await FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${UserCred.user!.uid}.jpg');

        await storage_ref.putFile(_selectedimage!);
        final imageUrl = await storage_ref.getDownloadURL();
        print(imageUrl);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(UserCred.user!.uid)
            .set({
          'user_name': entered_username,
          'email': entered_email,
          'imageUrl': imageUrl,
        });
      }
    } on FirebaseAuthException catch (error) {
      // ignore: unrelated_type_equality_checks
      if (error == 'email-already-in-use') {
        // ...
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication failed')));

      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('lib/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                        key: _formkey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!is_Login)
                              UserImage(
                                onPickImage: (pick_image) {
                                  _selectedimage = pick_image;
                                },
                              ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Email Address'),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                entered_email = value!;
                              },
                            ),
                            if (!is_Login)
                              TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Username'),
                                enableSuggestions: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length < 4) {
                                    return 'The username must be atleast 4 characters long';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  entered_username = value!;
                                },
                              ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Password must be at least 6 characters long';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                entered_pass = value!;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (_isAuthenticating)
                              const CircularProgressIndicator(),
                            if (!_isAuthenticating)
                              ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer),
                                  child: Text(is_Login ? 'Login' : 'Signup')),
                            if (!_isAuthenticating)
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      is_Login = !is_Login;
                                    });
                                  },
                                  child: Text(is_Login
                                      ? 'Create an account'
                                      : 'I already have an account . Login')),
                          ],
                        )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
