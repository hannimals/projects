import 'package:flutter/material.dart';
import 'package:yn_arround_the_world/start.dart';
import 'main_display_shop.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 113, 45, 230),
        ),
      ),

      home: const GeografiApp(),
    );
  }
}
