// lib/main.dart
import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData(
        primaryColor: const Color(0xFFA294F9), // Dark Purple
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFC1A6FF), // Medium Purple
        ),
        scaffoldBackgroundColor: const Color(0xFFF5EFFF), // Light Purple
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
      home: const LoginPage(),
    );
  }
}