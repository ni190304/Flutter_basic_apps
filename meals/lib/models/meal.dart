import 'package:flutter/material.dart';

enum Complexity {
  simple,
  challenging,
  diff,
}

enum Affordability {
  affordabile,
  pricey,
  liuxurioys,
}

class Meal {
  const Meal(
      {required this.id,
      required this.categories,
      required this.title,
      required this.imgurl,
      required this.affordability,
      required this.complexity,
      required this.duration,
      required this.ingr,
      required this.isGlutenfree,
      required this.isLactosefree,
      required this.isVegan,
      required this.isVegetarian,
      required this.steps});

  final String id;
  final List<String> categories;
  final String title;
  final String imgurl;
  final List<String> ingr;
  final List<String> steps;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final bool isGlutenfree;
  final bool isLactosefree;
  final bool isVegan;
  final bool isVegetarian;
}
