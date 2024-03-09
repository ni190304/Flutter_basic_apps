import 'package:flutter/material.dart';

class Texxt extends StatelessWidget {
  const Texxt({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 40.0),
      child: Text('Roll the dice',style: TextStyle(
        fontSize: 30,
        color: Colors.white,
      ),
      ),
    );
  }
}