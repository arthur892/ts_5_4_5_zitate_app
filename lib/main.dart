import 'package:flutter/material.dart';
import 'package:ts_5_4_5_zitate_app/quotes/quotes_screen.dart';
import 'package:ts_5_4_5_zitate_app/theme/theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.system;
  bool _isDarkMode = true;
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    setState(() {
      if (_isDarkMode) {
        themeMode = ThemeMode.dark;
      } else {
        themeMode = ThemeMode.light;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: themeMode,
      theme: GlobalThemeData.lightThemeData,
      darkTheme: GlobalThemeData.darkThemeData,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Quotes App"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: toggleTheme,
              ),
            ],
          ),
          body: const QuotesScreen()),
    );
  }
}
