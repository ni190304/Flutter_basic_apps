import 'package:flutter/material.dart';
import 'package:meals/categitem.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/meals.dart';
import 'package:meals/models/categ.dart';

import 'models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.availMeals});

  final List<Meal> availMeals;

  void _onselectcategory(BuildContext context, Category category) {
    final filtered_meals = availMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) =>
                MealsScreen(title: category.title, meals: filtered_meals,)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (final category in dummy_data)
          CategoryGridItem(
            category: category,
            onSelectcategory: () {
              _onselectcategory(context, category);
            },
          )
      ],
    );
  }
}
