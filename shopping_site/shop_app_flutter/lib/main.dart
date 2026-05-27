import 'package:flutter/material.dart';
import 'main_display_shop.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(215, 229, 240, 1),
        fontFamily: 'Manrope',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 45, 134, 230),
          primary: Color.fromRGBO(163, 194, 229, 1),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          prefixIconColor: Color.fromARGB(255, 240, 226, 226),
        ),
      ),

      home: ShoppingApp(),
    );
  }
}
