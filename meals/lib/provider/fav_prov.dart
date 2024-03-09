import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:riverpod/riverpod.dart';

class FavNotifier extends StateNotifier<List<Meal>>{
  FavNotifier() : super([]);

  bool toggleMeal(Meal meal){
    final mealisFav = state.contains(meal);

    if(mealisFav){
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }
    else{
      state = [...state,meal];
      return true;
    }
  }
}

final favprovider = StateNotifierProvider<FavNotifier,List<Meal>>((ref){
  return FavNotifier();
});