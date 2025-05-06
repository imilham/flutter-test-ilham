import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                // fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                context.read<SearchProvider>().updateSearch(value);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<SearchState>(
                stream: context.read<SearchProvider>().searchResults,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text('Start typing to search'));
                  }

                  final state = snapshot.data!;
                  return switch (state) {
                    SearchInitial() => const Center(child: Text('Start typing to search')),
                    SearchLoading() => const Center(child: CircularProgressIndicator()),
                    SearchSuccess(results: final results) => ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(results[index]),
                          leading: const Icon(Icons.article),
                          onTap: () {
                            // Handle item tap
                          },
                        );
                      },
                    ),
                    SearchError(message: final message) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 48),
                          const SizedBox(height: 16),
                          Text('Error: $message', style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Retry search
                              if (_controller.text.isNotEmpty) {
                                context.read<SearchProvider>().updateSearch(_controller.text);
                              }
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                    SearchEmpty() => const Center(child: Text('No results found')),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
