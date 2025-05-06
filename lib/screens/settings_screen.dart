import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearchVisible = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showTermsAndConditions() {
    showCupertinoModalPopup(
      context: context,
      builder:
          (context) => CupertinoActionSheet(
            title: const Text('Terms & Conditions'),
            message: const Text(
              'By using this application, you agree to our terms and conditions. '
              'This is a sample terms and conditions text that would typically '
              'contain detailed information about user agreements, privacy policy, '
              'and other legal information.',
              style: TextStyle(fontSize: 14),
            ),
            actions: [CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), child: const Text('Accept'))],
            cancelButton: CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), isDestructiveAction: true, child: const Text('Close')),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.reverse) {
              if (_isSearchVisible) {
                setState(() => _isSearchVisible = false);
              }
            } else if (notification.direction == ScrollDirection.forward) {
              if (!_isSearchVisible) {
                setState(() => _isSearchVisible = true);
              }
            }
            return true;
          },
          child: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: const Text('Settings'),
                border: null,
                stretch: true,
                padding: EdgeInsetsDirectional.zero,
                backgroundColor: CupertinoColors.systemBackground.withOpacity(0.9),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(56.0),
                  child: AnimatedOpacity(
                    opacity: _isSearchVisible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CupertinoSearchTextField(
                        controller: _searchController,
                        placeholder: 'Search settings...',
                        onChanged: (value) {
                          // Handle search
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSettingsItem('Notifications', CupertinoIcons.bell, onTap: () {}),
                      _buildSettingsItem('Appearance', CupertinoIcons.person, onTap: () {}),
                      _buildSettingsItem('Privacy', CupertinoIcons.lock, onTap: () {}),
                      _buildSettingsItem('Terms & Conditions', CupertinoIcons.doc_text, onTap: _showTermsAndConditions),
                      const SizedBox(height: 32),
                      const Text('Profile Card', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.blue.shade300, Colors.blue.shade100, Colors.blue.shade200]).createShader(bounds);
                        },
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 5))]),
                          alignment: Alignment.center,
                          child: const Text('Profile Card', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: CupertinoColors.separator, width: 0.5))),
        child: Row(children: [Icon(icon, color: CupertinoColors.activeBlue), const SizedBox(width: 12), Text(title, style: const TextStyle(fontSize: 16)), const Spacer(), const Icon(CupertinoIcons.chevron_right, color: CupertinoColors.systemGrey, size: 18)]),
      ),
    );
  }
}
