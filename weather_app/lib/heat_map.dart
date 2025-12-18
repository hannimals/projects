import 'dart:convert';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:weather_app/key_secret.dart';

class HeatMapScreen extends StatefulWidget {
  final double lat;
  final double lon;
  final String cityName;
  final String countryName;
  final double currentTemp;

  const HeatMapScreen({
    super.key,
    required this.lat,
    required this.lon,
    required this.cityName,
    required this.countryName,
    required this.currentTemp,
  });

  @override
  State<HeatMapScreen> createState() => _HeatMapScreenState();
}

//in the future we should make a map list of Country : countrycode so when we have widget.countryName we can use the list to convert it to the respective countrycode

class _HeatMapScreenState extends State<HeatMapScreen> {
  final String countryCode = 'CO';

  Future<List<Map<String, dynamic>>> _loadCitiesInCountry(
    String countryCode,
  ) async {
    // here is countrycode a parameter so the function runs for our desired country

    final String data = await DefaultAssetBundle.of(context).loadString(
      'assets/data/cities500.json',
    ); // the default asset bundle loads the assets from the pubspec.yaml file, it returns a type bundle and therefore we need to convert it to a string
    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList // now we clean up the jsonlist
        .where(
          (map) => map['country'] == countryCode,
        ) // here we say basically for each map (value) in the country that matches our countrycode return the single element as a map of type string and dynamic
        .where((map) {
          final popStr = map['pop'] as String?;
          final popul = popStr != null
              ? int.tryParse(popStr) ?? 0
              : 0; // we use tryparse because we are trying
          return popul >
              200000; // we say basically if if popStr =! null THEN tyrparse convert it to int and if that int is null just use 0, ELSE if popStr = Null use 0
        })
        .take(20)
        .cast<Map<String, dynamic>>()
        .toList(); // finally we convert the iterable to a list and return it
  }

  Future<Map<String, double>> _fetchCityTemperatures(
    List<Map<String, dynamic>> cities,
  ) async {
    final Map<String, double> cityTemps = {};
    for (final city in cities) {
      final lat = city['lat'].toString();
      final lon = city['lon'].toString();
      final name = city['name'].toString();
      final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$keyAPI&units=metric',
      );
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final temp = data['main']['temp'] as double;
          cityTemps[name] = temp;
        } else {
          if (kDebugMode) {
            print('response code was not 200. ${response.body}');
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print('network error for $name error $e');
        }
      }
    }
    return cityTemps;
  }
  /*
  
  for (int i = 0; i < cities.length; i += 20) {
      // we create a for loop to split the cities of a country in lists of 20
      final batch = cities.skip(i).take(20).toList();
      final List<String> latList = batch.map((map) {
        final lat = map['lat'].toString();

        return lat;
      }).toList();

      final List<String> longList = batch.map((map) {
        final lon = map['lon'].toString();
        return lon;
      }).toList();

      print('$latList, $longList');

      final latitud = latList.join(',');
      final longitud = longList.join(',');
      print('$latitud and $longitud');
      final url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitud&lon=$longitud&appid=$keyAPI',
      );
      print(url);*/

  Future<List<Marker>> _makeCityMarkers() async {
    final cities = await _loadCitiesInCountry(
      countryCode,
    ); //this returns a list of maps
    final temperature = await _fetchCityTemperatures(
      cities,
    ); // this returns a map of city names and temperatures

    return cities.map((city) {
      final double lat = double.tryParse(city['lat'] as String? ?? '0') ?? 0.0;
      final double lon = double.tryParse(city['lon'] as String? ?? '0') ?? 0.0;
      final name = city['name'] as String;

      final temp = temperature[name];
      return Marker(
        point: LatLng(lat, lon),
        height: 50,
        width: 120,
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.amber,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                name,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              Text(
                temp != null ? '${temp.toInt()}°C' : 'Loading...',
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HeatMap of your city ^^',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Marker>>(
        future: _makeCityMarkers(),
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
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('no data'));
          }

          if (snapshot.data == List.empty()) {
            return const Center(
              child: Text('empty list'),
            ); //this isnt printing currently
          }

          final markerList = snapshot.data!;

          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(widget.lat, widget.lon),
              initialZoom: 5.0,
              minZoom: 3.0, // <- permanent rules
              maxZoom: 50.0,
              keepAlive: true,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.hannimals.weatherapp',
              ),
              Opacity(
                opacity: 0.9,
                child: TileLayer(
                  urlTemplate:
                      'https://tile.openweathermap.org/map/temp_new/{z}/{x}/{y}.png?appid=$keyAPI',
                  additionalOptions: {'appid': keyAPI},
                ),
              ),
              MarkerLayer(markers: markerList),
            ],
          );
        },
      ),
    );
  }
}
