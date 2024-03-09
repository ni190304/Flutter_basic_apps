import 'package:flutter/material.dart';
import 'package:meals/models/categ.dart';
import 'package:meals/models/meal.dart';

const dummy_data = [
  Category(title: 'Italian', id: 'c1', color: Colors.orange),
  Category(title: 'Indian', id: 'c2', color: Color.fromARGB(255, 146, 219, 21)),
  Category(title: 'Mexican', id: 'c3', color: Color.fromARGB(255, 29, 16, 170)),
  Category(
      title: 'American', id: 'c4', color: Color.fromARGB(255, 33, 194, 49)),
  Category(title: 'French', id: 'c5', color: Color.fromARGB(255, 22, 179, 232)),
  Category(title: 'British', id: 'c6', color: Color.fromARGB(255, 6, 60, 7)),
  Category(
      title: 'Australian', id: 'c7', color: Color.fromARGB(255, 141, 76, 67)),
  Category(
      title: 'Sri Lankan', id: 'c8', color: Color.fromARGB(255, 92, 18, 141)),
  Category(title: 'Thai', id: 'c9', color: Color.fromARGB(255, 241, 34, 210)),
  Category(
      title: 'Our Special', id: 'c10', color: Color.fromARGB(255, 223, 43, 94)),
];

const dummy_meals = [
  Meal(
      id: 'm1',
      categories: ['c1', 'c2'],
      title: 'Spaghetti with Tomato Sauce',
      imgurl:
          'https://www.allrecipes.com/thmb/TlWVlYDsFDho1yHkdMbPS5sfyf4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/999096-3458e9f33928457e8d48a776a29ee57e.jpg',
      affordability: Affordability.affordabile,
      complexity: Complexity.simple,
      duration: 20,
      ingr: [
        '1 pound lean ground beef',
        '2 ½ cups chopped tomatoes',
        '1 ⅓ (6 ounce) cans tomato paste',
        '1 (4.5 ounce) can sliced mushrooms',
        '2 tablespoons dried minced onion',
        '1 teaspoon salt',
        '1 teaspoon dried oregano',
        '¾ teaspoon white sugar',
        '¼ teaspoon ground black pepper',
        '⅛ teaspoon garlic powder',
        '12 ounces spaghetti'
      ],
      isGlutenfree: true,
      isLactosefree: false,
      isVegan: true,
      isVegetarian: false,
      steps: ['1', 'X', 'Y', 'Q']),
  Meal(
      id: 'm1',
      categories: ['c2', 'c3'],
      title: 'Pav Bhaji',
      imgurl:
          'https://www.allrecipes.com/thmb/TlWVlYDsFDho1yHkdMbPS5sfyf4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/999096-3458e9f33928457e8d48a776a29ee57e.jpg',
      affordability: Affordability.affordabile,
      complexity: Complexity.simple,
      duration: 20,
      ingr: [
        '1 pound lean ground beef',
        '2 ½ cups chopped tomatoes',
        '1 ⅓ (6 ounce) cans tomato paste',
        '1 (4.5 ounce) can sliced mushrooms',
        '2 tablespoons dried minced onion',
        '1 teaspoon salt',
        '1 teaspoon dried oregano',
        '¾ teaspoon white sugar',
        '¼ teaspoon ground black pepper',
        '⅛ teaspoon garlic powder',
        '12 ounces spaghetti'
      ],
      isGlutenfree: true,
      isLactosefree: false,
      isVegan: true,
      isVegetarian: false,
      steps: ['1', 'X', 'Y', 'Q']),
  Meal(
      id: 'm1',
      categories: ['c3', 'c4'],
      title: 'Pizza',
      imgurl:
          'https://www.allrecipes.com/thmb/TlWVlYDsFDho1yHkdMbPS5sfyf4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/999096-3458e9f33928457e8d48a776a29ee57e.jpg',
      affordability: Affordability.affordabile,
      complexity: Complexity.simple,
      duration: 20,
      ingr: [
        '1 pound lean ground beef',
        '2 ½ cups chopped tomatoes',
        '1 ⅓ (6 ounce) cans tomato paste',
        '1 (4.5 ounce) can sliced mushrooms',
        '2 tablespoons dried minced onion',
        '1 teaspoon salt',
        '1 teaspoon dried oregano',
        '¾ teaspoon white sugar',
        '¼ teaspoon ground black pepper',
        '⅛ teaspoon garlic powder',
        '12 ounces spaghetti'
      ],
      isGlutenfree: true,
      isLactosefree: false,
      isVegan: true,
      isVegetarian: false,
      steps: ['1', 'X', 'Y', 'Q']),
  Meal(
      id: 'm1',
      categories: ['c4', 'c10'],
      title: 'Thepla',
      imgurl:
          'https://www.allrecipes.com/thmb/TlWVlYDsFDho1yHkdMbPS5sfyf4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/999096-3458e9f33928457e8d48a776a29ee57e.jpg',
      affordability: Affordability.affordabile,
      complexity: Complexity.simple,
      duration: 20,
      ingr: [
        '1 pound lean ground beef',
        '2 ½ cups chopped tomatoes',
        '1 ⅓ (6 ounce) cans tomato paste',
        '1 (4.5 ounce) can sliced mushrooms',
        '2 tablespoons dried minced onion',
        '1 teaspoon salt',
        '1 teaspoon dried oregano',
        '¾ teaspoon white sugar',
        '¼ teaspoon ground black pepper',
        '⅛ teaspoon garlic powder',
        '12 ounces spaghetti'
      ],
      isGlutenfree: true,
      isLactosefree: false,
      isVegan: true,
      isVegetarian: false,
      steps: ['1', 'X', 'Y', 'Q']),
  Meal(
      id: 'm1',
      categories: ['c10', 'c9'],
      title: 'Pani puri',
      imgurl:
          'https://www.allrecipes.com/thmb/TlWVlYDsFDho1yHkdMbPS5sfyf4=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/999096-3458e9f33928457e8d48a776a29ee57e.jpg',
      affordability: Affordability.affordabile,
      complexity: Complexity.simple,
      duration: 20,
      ingr: [
        '1 pound lean ground beef',
        '2 ½ cups chopped tomatoes',
        '1 ⅓ (6 ounce) cans tomato paste',
        '1 (4.5 ounce) can sliced mushrooms',
        '2 tablespoons dried minced onion',
        '1 teaspoon salt',
        '1 teaspoon dried oregano',
        '¾ teaspoon white sugar',
        '¼ teaspoon ground black pepper',
        '⅛ teaspoon garlic powder',
        '12 ounces spaghetti'
      ],
      isGlutenfree: true,
      isLactosefree: false,
      isVegan: true,
      isVegetarian: false,
      steps: ['1', 'X', 'Y', 'Q']),
];
