import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/meal.dart';

class MealApiService {
  static const String _baseUrl = 'www.themealdb.com';

  Future<List<MealCategory>> fetchCategories() async {
    final uri = Uri.https(_baseUrl, '/api/json/v1/1/categories.php');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List categoriesJson = data['categories'] ?? [];
      return categoriesJson
          .map((json) => MealCategory.fromJson(json))
          .toList();
    } else {
      throw Exception('Не можам да ги преземам категориите');
    }
  }

  Future<List<Meal>> fetchMealsByCategory(String category) async {
    final uri = Uri.https(
      _baseUrl,
      '/api/json/v1/1/filter.php',
      {'c': category},
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List mealsJson = data['meals'] ?? [];
      return mealsJson.map((json) => Meal.fromFilterJson(json)).toList();
    } else {
      throw Exception('Не можам да ги преземам јадењата');
    }
  }

  Future<Meal> fetchMealDetail(String id) async {
    final uri = Uri.https(
      _baseUrl,
      '/api/json/v1/1/lookup.php',
      {'i': id},
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List mealsJson = data['meals'] ?? [];
      if (mealsJson.isEmpty) throw Exception('Нема рецепт');
      return Meal.fromDetailJson(mealsJson.first);
    } else {
      throw Exception('Не можам да го преземам рецептот');
    }
  }

  Future<Meal> fetchRandomMeal() async {
    final uri = Uri.https(
      _baseUrl,
      '/api/json/v1/1/random.php',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List mealsJson = data['meals'] ?? [];
      if (mealsJson.isEmpty) throw Exception('Нема рандом рецепт');
      return Meal.fromDetailJson(mealsJson.first);
    } else {
      throw Exception('Не можам да земам рандом рецепт');
    }
  }
}
