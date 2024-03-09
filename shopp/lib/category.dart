import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruits,
  meat,
  dairy,
  hygiene,
  others,
}

class Category {
  const Category(this.color, this.title);

  final String title;
  final Color color;
}
