import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//give the user option to change the theme
// give option to change game mode (CEO/Y_N)
//sign in/ out T_T

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.light_mode),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('not available yet')),
                  );
                },
                tooltip: 'Change Theme',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('not available yet')),
                  );
                },
                child: const Text('My Account'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('not available yet')),
                  );
                },
                child: Text('Sign Out/Sign In'),
              ),
              const SizedBox(height: 20),

              // reset tutorial button
              ElevatedButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('mapTutorialCompleted');
                  if (!mounted) return;

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Map tutorial reset! Restart map view.'),
                    ),
                  );
                },
                child: const Text('Reset Map Tutorial (Debug)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
