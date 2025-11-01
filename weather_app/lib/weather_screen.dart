import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            //give you visual response and has a deafault padding, alternative could use inkwell and gesture detector
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (kDebugMode) {
                print('object');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          //main card
          Placeholder(
            fallbackHeight: 250,
            child: const Text('main weather data'),
          ),
        ],
      ),
    );
  }
}
//13;32