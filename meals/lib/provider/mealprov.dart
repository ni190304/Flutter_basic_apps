import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:riverpod/riverpod.dart';

final mealprovider = Provider((ref){
  return dummy_meals;

});