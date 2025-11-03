import 'dart:ui';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                color: const Color.fromARGB(255, 79, 117, 128),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Text(
                            '30°C',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(Icons.cloud, size: 50),
                          const SizedBox(height: 10),
                          const Text('cloudy'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Placeholder(
              //weather forecast
              fallbackHeight: 150,
            ),
            const SizedBox(height: 20),
            //aditional info
            Placeholder(fallbackHeight: 100),
          ],
        ),
      ),
    );
  }
}

//13;52
