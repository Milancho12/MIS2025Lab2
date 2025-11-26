import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/meal.dart';
import '../services/meal_api_service.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  final MealApiService _apiService = MealApiService();
  Meal? _meal;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMeal();
  }

  Future<void> _loadMeal() async {
    try {
      final meal = await _apiService.fetchMealDetail(widget.mealId);
      if (!mounted) return;
      setState(() {
        _meal = meal;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _openYoutube() async {
    final url = _meal?.youtubeUrl;
    if (url == null || url.isEmpty) return;

    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF9F9F9),
    appBar: AppBar(
      title: Text(_meal?.name ?? 'Meal Details'),
      backgroundColor: const Color(0xFF6A4C93),
      foregroundColor: Colors.white,
    ),
    body: _loading
        ? const Center(child: CircularProgressIndicator())
        : _meal == null
            ? const Center(child: Text('No data'))
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          _meal!.thumbnail,
                          height: 230,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              
                              Text(
                                _meal!.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 8),

                              
                              if (_meal!.category != null)
                                Chip(
                                  label: Text(_meal!.category!),
                                  backgroundColor: Colors.deepOrange.shade100,
                                  labelStyle:
                                      const TextStyle(color: Colors.black87),
                                ),

                              const Divider(height: 24),

                              
                              const Text(
                                "Ingredients",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: _meal!.ingredients.entries.map(
                                  (e) => Chip(
                                    label: Text("${e.key} (${e.value})"),
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                ).toList(),
                              ),

                              const Divider(height: 24),

                              
                              const Text(
                                "Instructions",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                _meal!.instructions ?? '',
                                style:
                                    const TextStyle(height: 1.4, fontSize: 15),
                              ),

                              const SizedBox(height: 20),

                              
                              if (_meal!.youtubeUrl != null &&
                                  _meal!.youtubeUrl!.isNotEmpty)
                                Center(
                                  child: ElevatedButton.icon(
                                    onPressed: _openYoutube,
                                    icon: const Icon(Icons.play_circle),
                                    label: const Text("Watch on YouTube"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
  );
}

}
