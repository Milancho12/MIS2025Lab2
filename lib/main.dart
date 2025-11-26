import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MealsApp());
}

class MealsApp extends StatelessWidget {
  const MealsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  title: 'Meal Recipes',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6A4C93), // 🔥 Unikatna viola tema
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF6A4C93),
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF595E),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFE0C3FC),
      labelStyle: const TextStyle(color: Colors.black),
      selectedColor: const Color(0xFF6A4C93),
    ),
  ),
  home: const CategoriesScreen(),
);

  }
}
