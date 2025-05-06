import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../services/search_service.dart';

// Different states our search can be in
sealed class SearchState {}

// Initial state before any search is done

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<String> results;
  SearchSuccess(this.results);
}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}

class SearchEmpty extends SearchState {}

// Manages search state and handles real-time search updates
class SearchProvider extends ChangeNotifier {
  // final SearchService _searchService;

  // Controllers for handling search input and results
  final _searchController = BehaviorSubject<String>();
  final _resultsController = BehaviorSubject<SearchState>.seeded(SearchInitial());

  // Stream getters
  Stream<SearchState> get searchResults => _resultsController.stream;
  Function(String) get updateSearch => _searchController.sink.add;

  SearchProvider() {
    // Set up reactive search pipeline with debouncing and error handling
    _searchController.stream.debounceTime(const Duration(milliseconds: 300)).distinct().switchMap((query) => _performSearch(query)).listen((state) => _resultsController.add(state), onError: (error) => _resultsController.add(SearchError(error.toString())));
  }

  // Performs the actual search and manages state transitions
  Stream<SearchState> _performSearch(String query) async* {
    if (query.isEmpty) {
      yield SearchEmpty();
      return;
    }

    yield SearchLoading();

    try {
      final searchService = SearchService();
      // Get search results from service
      final results = await searchService.searchProducts(query);
      if (results.isEmpty) {
        yield SearchEmpty();
      } else {
        yield SearchSuccess(results);
      }
    } catch (e) {
      yield SearchError(e.toString());
    }
  }

  @override
  void dispose() {
    // Clean up resources when the provider is disposed
    _searchController.close();
    _resultsController.close();
    super.dispose();
  }
}
