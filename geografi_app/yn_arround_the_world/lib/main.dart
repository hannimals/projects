import 'package:flutter/material.dart';
import 'package:yn_arround_the_world/main_menu.dart';
import 'package:yn_arround_the_world/map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'y/n arround the world',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: MainMenu(),
    );
  }
}
