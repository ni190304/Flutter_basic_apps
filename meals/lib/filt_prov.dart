import 'package:riverpod/riverpod.dart';
import 'package:flutter/material.dart';

enum Filter {
  glutenFreeset,
  lactoseFreeset,
  vegan,
  veget,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>>{
  FiltersNotifier() :super({

    Filter.glutenFreeset : false,
    Filter.lactoseFreeset : false,
    Filter.vegan : false,
    Filter.veget : false,

  });

  void setFilter(Filter filter, bool isActive){
    state = {
      ...state,
      filter: isActive,

    }
  }
}

final filterProv = StateNotifierProvider((ref) => null)