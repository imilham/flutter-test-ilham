import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Implement the search screen UI
    // Requirements:
    // - Create a TextField for user input
    // - Display search results in a ListView
    // - Show loading indicator while waiting for results
    // - Display a message if no results or errors
    // - Connect to the SearchProvider for state
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TODO: Implement the search TextField
            
            // TODO: Implement the results ListView with appropriate states
            // - Loading state
            // - Error state
            // - Empty state
            // - Success state with results
            
            Expanded(
              child: Center(
                child: Text(
                  'Implement search functionality using RxDart and Provider',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
