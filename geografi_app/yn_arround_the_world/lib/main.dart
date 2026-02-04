import 'package:flutter/material.dart';
import 'main_menu.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'y/n arround the world',
          debugShowCheckedModeBanner: false,

          theme: ThemeData(
            colorScheme: lightDynamic,
            primaryColor: Color.fromRGBO(57, 63, 81, 100),
            brightness: Brightness.light,
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            primaryColor: Color.fromRGBO(33, 75, 110, 1),
            brightness: Brightness.dark,
            colorScheme: darkDynamic,

            useMaterial3: false,
          ),

          themeMode: ThemeMode.dark,

          home: MainMenu(),
        );
      },
    );
  }
}
