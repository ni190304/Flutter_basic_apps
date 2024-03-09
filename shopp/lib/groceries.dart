import 'package:shopp/categories.dart';
import 'package:shopp/category.dart';
import 'package:shopp/grocery.dart';

final groceries = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 2,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 3,
      category: categories[Categories.fruits]!),
  GroceryItem(
      id: 'c',
      name: 'Chicken',
      quantity: 5,
      category: categories[Categories.meat]!)
];
