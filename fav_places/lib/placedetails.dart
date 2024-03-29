import 'dart:io';

import 'package:fav_places/place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key,required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image.file(place.image,height: double.infinity,width: double.infinity,fit: BoxFit.cover,)
        ],
      )

    );
  }
}