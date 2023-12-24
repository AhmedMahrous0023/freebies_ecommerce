import 'package:flutter/material.dart';
import 'package:freebies_ecommerce/views/bottom_navigator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavigatorScreen(),
    );
  }
}