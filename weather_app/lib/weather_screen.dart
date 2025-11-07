import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'forecast_forhours.dart';
import 'aditional_info_item.dart';

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
                color: const Color.fromARGB(255, 61, 61, 61),
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
            //weather forecast
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Weather forecast',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            const SizedBox(height: 5),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Houlyforecascards(),
                  Houlyforecascards(),
                  Houlyforecascards(),
                  Houlyforecascards(),
                  Houlyforecascards(),
                  Houlyforecascards(),
                  Houlyforecascards(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Additional Information',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '91',
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Wind speed',
                  value: '7.5',
                ),
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1000',
                ),
              ],
            ),

            //last app bar
            AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.map),
                  onPressed: () {
                    if (kDebugMode) {
                      print('object');
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//13;52
