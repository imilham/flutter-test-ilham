import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import '../services/search_service.dart';

// Search states
sealed class SearchState {}

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

class SearchProvider extends ChangeNotifier {
  final SearchService _searchService;
  
  // Stream controllers
  final _searchController = BehaviorSubject<String>();
  final _resultsController = BehaviorSubject<SearchState>.seeded(SearchInitial());

  // Stream getters
  Stream<SearchState> get searchResults => _resultsController.stream;
  Function(String) get updateSearch => _searchController.sink.add;

  SearchProvider(this._searchService) {
    // Set up search pipeline
    _searchController.stream
        .debounceTime(const Duration(milliseconds: 300))
        .distinct()
        .switchMap((query) => _performSearch(query))
        .listen(
          (state) => _resultsController.add(state),
          onError: (error) => _resultsController.add(
            SearchError(error.toString()),
          ),
        );
  }

  Stream<SearchState> _performSearch(String query) async* {
    if (query.isEmpty) {
      yield SearchEmpty();
      return;
    }

    yield SearchLoading();

    try {
      final results = await _searchService.searchItems(query);
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
    _searchController.close();
    _resultsController.close();
    super.dispose();
  }
}
