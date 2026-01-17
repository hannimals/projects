import 'package:flutter/material.dart';
import 'package:yn_arround_the_world/settings.dart';

class Quizz extends StatelessWidget {
  const Quizz({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose your travel location...',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.emoji_people),
            tooltip: 'Friend list',
          ),
        ],
      ),
      //body: SafeArea(child: vedikkemenenwidgetdervirkerfordig ())
      // make a quizz dialog/card der fylder halvdelen af siden og ved siden en resume med achievments og point med ikoner
    );
  }
}
