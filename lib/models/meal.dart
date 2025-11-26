class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String? category;
  final String? instructions;
  final String? youtubeUrl;
  final Map<String, String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.category,
    this.instructions,
    this.youtubeUrl,
    this.ingredients = const {},
  });


  factory Meal.fromFilterJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
    );
  }


  factory Meal.fromDetailJson(Map<String, dynamic> json) {
    final Map<String, String> ingredients = {};

    
    for (int i = 1; i <= 20; i++) {
      final ing = (json['strIngredient$i'] ?? '').toString().trim();
      final meas = (json['strMeasure$i'] ?? '').toString().trim();
      if (ing.isNotEmpty) {
        ingredients[ing] = meas;
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      category: json['strCategory'],
      instructions: json['strInstructions'],
      youtubeUrl: json['strYoutube'],
      ingredients: ingredients,
    );
  }
}
