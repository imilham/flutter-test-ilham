import 'dart:async';
import 'dart:math';

class SearchService {
  final List<String> _mockData = [
    'Flutter Development',
    'Dart Programming',
    'Mobile App Development',
    'iOS Development',
    'Android Development',
    'Cross-platform Development',
    'UI/UX Design',
    'State Management',
    'Backend Integration',
    'API Development',
    'Testing Strategies',
    'Performance Optimization'
  ];

  final Random _random = Random();

  Future<List<String>> searchItems(String query) async {
    // Simulate network delay between 200ms and 1000ms
    await Future.delayed(Duration(milliseconds: 200 + _random.nextInt(800)));

    // Simulate random errors (10% chance)
    if (_random.nextDouble() < 0.1) {
      throw Exception('Failed to fetch search results');
    }

    if (query.isEmpty) {
      return [];
    }

    // Filter mock data based on query
    return _mockData
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
