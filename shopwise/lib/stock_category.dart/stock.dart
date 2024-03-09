import 'package:flutter/material.dart';

enum Categories { fruits, vegetables, pulses, edible_oils }

class Category {
  const Category(this.title);

  final String title;
}

const categories = {
  Categories.fruits: Category('Fruits'),
  Categories.edible_oils: Category('Edible oils'),
  Categories.pulses: Category('Pulses'),
  Categories.vegetables: Category('Vegetables'),
};
