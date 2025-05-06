import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: [
            // TODO: Implement CupertinoSliverNavigationBar
            // Requirements:
            // - Use CupertinoSliverNavigationBar
            // - Display a large title when fully expanded
            // - Include a CupertinoSearchTextField as the bottom widget
            // - Configure bottomMode to hide search field on scroll
            // - Navigation bar should snap between expanded and collapsed states
            
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Placeholder settings items
                    _buildSettingsItem(
                      'Notifications',
                      CupertinoIcons.bell,
                      onTap: () {},
                    ),
                    _buildSettingsItem(
                      'Appearance',
                      CupertinoIcons.person,
                      onTap: () {},
                    ),
                    _buildSettingsItem(
                      'Privacy',
                      CupertinoIcons.lock,
                      onTap: () {},
                    ),
                    _buildSettingsItem(
                      'Terms & Conditions',
                      CupertinoIcons.doc_text,
                      onTap: () {
                        // TODO: Implement showCupertinoSheet
                        // Requirements:
                        // - Use the new showCupertinoSheet function
                        // - Show placeholder terms and conditions text
                        // - Allow dismissal via drag-to-dismiss gesture
                      },
                    ),
                    
                    const SizedBox(height: 32),
                    const Text(
                      'Profile Card',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      // TODO: (Bonus) Apply custom visual effect
                      // Requirements:
                      // - Apply a custom visual effect using ImageFilter.shader 
                      // - Create a simple shader (gradient or noise effect)
                      child: const Text(
                        'Profile Card',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.separator,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: CupertinoColors.activeBlue),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
