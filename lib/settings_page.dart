// lib/settings_page.dart
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: const Text('Change Username'),
              onTap: () {
                // Implement change username functionality
              },
            ),
            ListTile(
              title: const Text('Change Password'),
              onTap: () {
                // Implement change password functionality
              },
            ),
            ListTile(
              title: const Text('Notifications'),
              onTap: () {
                // Implement notification settings functionality
              },
            ),
            ListTile(
              title: const Text('About App'),
              onTap: () {
                // Show app information
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // Implement logout functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}