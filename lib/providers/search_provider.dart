import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../services/search_service.dart';

// TODO: Implement SearchProvider using ChangeNotifier
// Requirements:
// - Create a class that extends ChangeNotifier
// - Use BehaviorSubject for search query stream
// - Apply rxdart operators (debounceTime, distinct, switchMap)
// - Handle potential errors gracefully
// - Emit states for Loading, Success, Error, and Empty

enum SearchState {
  initial,
  loading,
  success,
  error,
  empty,
}

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService;
  
  // TODO: Add state variables
  
  // TODO: Add BehaviorSubject for search queries
  
  SearchProvider({SearchService? searchService}) 
      : _searchService = searchService ?? SearchService() {
    // TODO: Initialize search stream with operators
    // - Use debounceTime (300ms)
    // - Use distinct operator
    // - Use switchMap for API calls
    // - Handle errors within stream
  }
  
  // TODO: Implement methods to update search query
  
  // TODO: Implement clean up for streams
  @override
  void dispose() {
    // TODO: Clean up any streams
    super.dispose();
  }
}
