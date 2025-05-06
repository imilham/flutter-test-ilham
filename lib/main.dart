// Main app file - sets up providers and routing
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/settings_screen.dart';
import 'screens/search_screen.dart';
import 'screens/user_profile_screen.dart';
import 'providers/user_provider.dart';
import 'providers/search_provider.dart';
import 'services/search_service.dart';
import 'repositories/user_repository.dart';

void main() {
  runApp(const MyApp());
}

// Root widget that configures the app's providers and theme
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        /// [SearchService] handles the actual search operations
        Provider(create: (context) => SearchService()),
        /// [SearchProvider] manages search state and results using streams
        ChangeNotifierProvider(
          create: (context) => SearchProvider(context.read<SearchService>()),
        ),
        /// [UserRepository] handles API calls and data fetching
        Provider(
          create: (context) => UserRepository(),
          dispose: (context, repository) => repository.dispose(),
        ),
        /// [UserProvider] manages user state and [loading/error states]
        ChangeNotifierProvider(
          create: (context) => UserProvider(
            repository: context.read<UserRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Coding Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/settings': (context) => const SettingsScreen(),
          '/search': (context) => const SearchScreen(),
          '/user-profile': (context) => const UserProfileScreen(userId: '1'),
        },
      ),
    );
  }
}

/// Main screen with navigation buttons to different features
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Coding Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Part 1: Settings Screen (Cupertino)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
              child: const Text('Part 2: Search Screen (RxDart)'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/user-profile');
              },
              child: const Text('Part 3: User Profile (Refactoring)'),
            ),
          ],
        ),
      ),
    );
  }
}
