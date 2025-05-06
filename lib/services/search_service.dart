import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';

/// Service that handles search functionality with mock data
class SearchService {
  /// Sample topics we can search through - simulates a backend API
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

  /// Searches through mock data with simulated network behavior
  /// 
  Future<List<String>> searchProducts(String query) async {
    try {
      /// Add random delay to feel like a real API [500ms-1000ms)]
      await Future.delayed(Duration(milliseconds: 500 + _random.nextInt(800)));

      /// Sometimes fail to show how error states work [10% chance]
      if (_random.nextDouble() < 0.1) {
        throw Exception('Failed to fetch search results');
      }

      if (query.isEmpty) {
        return [];
      }

      /// Search through our topics, ignoring case
      return _mockData
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      debugPrint('Error occurred: $e');
      rethrow; // Rethrow the error to propagate it further
    }
  }
}
