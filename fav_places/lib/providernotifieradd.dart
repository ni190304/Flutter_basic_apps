import 'dart:io';

import 'package:fav_places/place.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class Userplaces extends StateNotifier<List<Place>>{
  Userplaces() : super([]);

  void add_place(String title,File image){
    final newplace = Place(title: title,image: image);

    state = [newplace,...state];

  }
}

final userplacesprovider = StateNotifierProvider<Userplaces,List<Place>>((ref) => Userplaces());