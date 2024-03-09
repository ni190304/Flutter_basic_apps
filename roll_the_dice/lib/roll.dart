import 'package:flutter/material.dart';
import 'dart:math';
import 'package:roll_the_dice/text.dart';

class Roll extends StatefulWidget {
  const Roll({super.key});

  @override
  State<Roll> createState() => _RollState();
}

class _RollState extends State<Roll> {

  var current_img = "lib/images/dice1.png";

  void Rolldice() {
    var current_index = Random().nextInt(6) + 1;
    setState(() {
      
      current_img = "lib/images/dice$current_index.png";
    });
    print('Dabaya be!!! Hattttt...');
  }

  @override
  Widget build(BuildContext context) {
      return SafeArea(
         child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Image.asset(current_img,width: 250,height: 250,),

                const SizedBox(height: 10,),

                TextButton(onPressed: Rolldice, child: const Texxt())
                  
                  
                ],
                    
                ),
            ),
          );
  }
}