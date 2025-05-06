import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../models/user.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;
  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _refreshUser(context),
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    /// Trigger initial fetch
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<UserProvider>().status == UserStatus.initial) {
        context.read<UserProvider>().fetchUser(userId);
      }
    });

    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Center(
          child: switch (provider.status) {
            UserStatus.loading => const CircularProgressIndicator(),
            UserStatus.error => _buildError(provider.error),
            UserStatus.success => _buildUserProfile(context, provider.user!),
            UserStatus.initial => const SizedBox.shrink(),
          },
        );
      },
    );
  }

  Widget _buildError(String? error) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        error ?? 'An unknown error occurred',
        style: const TextStyle(color: Colors.red),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context, User user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name: ${user.name}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text('Email: ${user.email}'),
          const SizedBox(height: 8),
          Text('Phone: ${user.phone}'),
          const SizedBox(height: 8),
          Text('Website: ${user.website}'),
        ],
      ),
    );
  }

  void _refreshUser(BuildContext context) {
    context.read<UserProvider>().fetchUser(userId);
  }
}
