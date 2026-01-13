import 'package:flutter/material.dart';
import 'package:yn_arround_the_world/main_menu.dart';
//give the user option to change the theme
// give option to change game mode (CEO/Y_N)
//sign in/ out T_T

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.light_mode),
                onPressed: () {},
                tooltip: 'Change Theme',
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: const Text('My Account')),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () {}, child: Text('Sign Out/Sign In')),
            ],
          ),
        ),
      ),
    );
  }
}
