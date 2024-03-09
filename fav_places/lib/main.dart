import 'package:fav_places/placeslistscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod/riverpod.dart';

final colorsch = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 102, 6, 247),
    brightness: Brightness.dark,
    background: const Color.fromARGB(255, 56, 49, 66));

final theme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: colorsch.background,
    colorScheme: colorsch,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
        titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold,fontSize: 35),
        titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold,fontSize: 30),
        titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold,fontSize: 25)));

void main() {
  runApp(ProviderScope(child: const Main()));
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const PlacesScreen(),
    );
  }
}
