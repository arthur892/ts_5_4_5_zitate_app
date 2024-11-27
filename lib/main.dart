import 'package:flutter/material.dart';
import 'package:ts_5_4_5_zitate_app/quotes/quotes_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Quotes App"),
            centerTitle: true,
          ),
          body: const QuotesScreen()),
    );
  }
}
