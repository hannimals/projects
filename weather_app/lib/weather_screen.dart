import 'dart:convert';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/key_secret.dart';
import 'forecast_forhours.dart';
import 'aditional_info_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String? _errors;
  double _kelvintemp = 0.0;
  double _temp = 0.0;
  bool _isLoading = false;
  static final String cityName = 'London';
  static final String _apiurl =
      'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$keyAPI';

  @override
  void initState() {
    super.initState();
    _getCurrentWeather();
  }

  Future _getCurrentWeather() async {
    setState(() {
      _isLoading = true;
      // reset errors before making a new request
      _errors = null;
    });
    try {
      final result = await http.get(Uri.parse(_apiurl));

      if (result.statusCode != 200) {
        throw Exception('an unexpected error ocurred: ${result.statusCode}');
      }
      final data = jsonDecode(result.body);

      /*if (int.parse(data['cod']) != 200) {
        // we convert the code to int to compare it
        throw Exception(
          'an unexpected error ocurred: ${result.statusCode}',
        );
         // we show the error based on the status code
      }*/

      setState(() {
        _isLoading = false;
        _kelvintemp = data['list'][0]['main']['temp'];
        _temp = (_kelvintemp - 273.15);
      });
    } catch (e) {
      setState(() {
        _errors = 'after catch Error: ${e.toString()}';
        throw Exception(_errors);
        //we set the state to show the error
      });
    }
  }

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
          IconButton(
            onPressed: () {
              if (kDebugMode) {
                print('object');
              }
            },
            icon: Icon(Icons.map),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: const CircularProgressIndicator.adaptive()) // is it loading? then display progress indicator else padding :)
          : Padding(
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
                                  '${_temp.toStringAsFixed(1)} °C',
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Houlyforecascards(
                          time: '0;00',
                          temp: '30',
                          icon: (Icons.sunny),
                        ),
                        Houlyforecascards(
                          time: '3;00',
                          temp: '30',
                          icon: (Icons.sunny),
                        ),
                        Houlyforecascards(
                          time: '6;00',
                          temp: '30',
                          icon: (Icons.sunny),
                        ),
                        Houlyforecascards(
                          time: '9;00',
                          temp: '30',
                          icon: (Icons.sunny),
                        ),
                        Houlyforecascards(
                          time: '11;00',
                          temp: '30',
                          icon: (Icons.sunny),
                        ),
                        Houlyforecascards(
                          time: '15;00',
                          temp: '30',
                          icon: (Icons.sunny),
                        ),
                        Houlyforecascards(
                          time: '18;00',
                          temp: '30',
                          icon: (Icons.cloud),
                        ),
                        Houlyforecascards(
                          time: '21;00',
                          temp: '30',
                          icon: (Icons.mode_night),
                        ),
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
                ],
              ),
            ),
    );
  }
}


