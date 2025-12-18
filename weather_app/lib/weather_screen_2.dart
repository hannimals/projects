import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/heat_map.dart';
import 'package:weather_app/key_secret.dart';
import 'forecast_forhours.dart';
import 'aditional_info_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreenSeccond extends StatefulWidget {
  const WeatherScreenSeccond({super.key});

  @override
  State<WeatherScreenSeccond> createState() => _WeatherScreenSeccondState();
}

class _WeatherScreenSeccondState extends State<WeatherScreenSeccond> {
  static const String citynameInitial = 'Copenhagen';
  static const String countrynameInitial = 'Denmark';
  static final String _apiurl =
      'https://api.openweathermap.org/data/2.5/forecast?q=$citynameInitial,$countrynameInitial&APPID=$keyAPI&units=metric';
  late Future<Map<String, dynamic>> weatherFuture;

  @override
  void initState() {
    super.initState();
    weatherFuture = _getCurrentWeather(); // first future call
  }

  Future<Map<String, dynamic>> _getCurrentWeather() async {
    // we specify the type of data so we dont get dynamic
    try {
      final result = await http.get(Uri.parse(_apiurl));

      if (result.statusCode != 200) {
        final errorBody = jsonDecode(result.body);
        final message =
            errorBody['message'] ??
            [
              'unknown Error',
            ]; //The ?? operator is Dart’s null-coalescing operator
        throw Exception(
          'an unexpected error ocurred: $message (error code: ${result.statusCode})',
        );
      }

      final data = jsonDecode(result.body);

      return data;
    } catch (e) {
      throw Exception('$e <-- Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:
            weatherFuture, // a snapshots future is the future we pass in this case weatherFuture, it means the future builder is listening to that future so when it completes it rebuilds itself
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 64),
                  const SizedBox(height: 10),
                  Text(snapshot.error.toString(), textAlign: TextAlign.center),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => setState(() {
                      weatherFuture = _getCurrentWeather();
                    }),
                    child: const Text('reload'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('no data'));
          }

          final data = snapshot.data!;
          final currentForecastData = data['list'][0];
          final double currentTemp = currentForecastData['main']['temp'];
          final currentWeather =
              currentForecastData['weather'][0]['description'];
          final currentSky = currentForecastData['weather'][0]['main'];
          final currentPressure = currentForecastData['main']['pressure'];
          final currentWindSpeed = currentForecastData['wind']['speed'];
          final double currentTermicalSensation =
              (currentForecastData['main']['feels_like']);
          final currentHumidity = currentForecastData['main']['humidity'];
          final double lat = data['city']['coord']['lat'] as double;
          final double lon = data['city']['coord']['lon'] as double;
          final String cityName = data['city']['name'];
          final String countryName = data['city']['country'];

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
                    setState(
                      () {
                        weatherFuture = _getCurrentWeather();
                      },
                    ); //re initializing the future call so it works each time and not once
                  },
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HeatMapScreen(
                          currentTemp: currentTemp,
                          lat: lat,
                          lon: lon,
                          cityName: cityName,
                          countryName: countryName,
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.map),
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
                                  '${currentTemp.toStringAsFixed(0)}°C',
                                  style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  currentSky == 'Clouds'
                                      ? Icons.cloud
                                      : currentSky == 'Rain'
                                      ? Icons.beach_access_sharp
                                      : currentSky == 'Snow'
                                      ? Icons.cloudy_snowing
                                      : Icons.sunny,
                                  size: 50,
                                ),
                                const SizedBox(height: 10),
                                Text('$currentWeather'),
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
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 9,
                      itemBuilder: (context, index) {
                        final hourlyForecastData = data['list'][index + 1];
                        final hourlyWeatherData =
                            hourlyForecastData['weather'][0]['main'];
                        final foreecastTemp =
                            hourlyForecastData['main']['temp'];
                        final time = DateTime.parse(
                          hourlyForecastData['dt_txt'],
                        );
                        return Houlyforecascards(
                          time: DateFormat.Hm().format(time),
                          temp: '${(foreecastTemp).toStringAsFixed(0)}°C',
                          icon: (hourlyWeatherData) == 'Clear'
                              ? (Icons.sunny)
                              : (hourlyWeatherData) == 'Clouds'
                              ? (Icons.cloud)
                              : (hourlyWeatherData) == 'Rain'
                              ? (Icons.water_drop)
                              : Icons.cloudy_snowing,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Additional Information',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AdditionalInfoItem(
                        icon: Icons.water_drop,
                        label: 'Humidity',
                        value: '${currentHumidity.toString()}%',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.air,
                        label: 'Wind speed',
                        value: '${currentWindSpeed.toString()}m/s',
                      ),
                      AdditionalInfoItem(
                        icon: Icons.beach_access,
                        label: 'Pressure',
                        value: '${currentPressure.toString()}hPa',
                      ),
                      AdditionalInfoItem(
                        icon: currentTermicalSensation < 18
                            ? Icons.ac_unit
                            : Icons.device_thermostat,
                        label: 'Sensation',
                        value:
                            '${currentTermicalSensation.toStringAsFixed(0)}°C',
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      'Forecast of $cityName, $countryName',
                      style: TextStyle(fontSize: 15, color: Colors.white30),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
