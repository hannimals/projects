import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:yn_arround_the_world/main_menu.dart';
import 'package:yn_arround_the_world/marker_blueprint.dart';
import 'package:yn_arround_the_world/settings.dart';

class GeografiApp extends StatefulWidget {
  const GeografiApp({super.key});

  @override
  State<GeografiApp> createState() => _GeografiAppState();
}

class _GeografiAppState extends State<GeografiApp> {
  final List<TravelLocation> travelSpots = [
    TravelLocation(
      country: 'spain',
      city: 'Barcelona',
      landmark: 'La Sagrada Familia',
      latitude: 41.3851,
      longitude: 2.1734,
    ), //ved brug af AI har vi fundet lat og long af alle vores udvalgte byer på kortest tid.
    TravelLocation(
      country: 'spain',
      city: 'Madrid',
      landmark: 'Royal palace',
      latitude: 40.4168,
      longitude: -3.7038,
    ),
    TravelLocation(
      country: 'France',
      city: 'Paris',
      landmark: 'Eiffel Tower',
      latitude: 48.8584,
      longitude: 2.2945,
    ),
    TravelLocation(
      country: 'Colombia',
      city: 'San Andrés Island',
      landmark: 'The seven colors sea',
      latitude: 12.5847,
      longitude: -81.7000,
    ),
    TravelLocation(
      country: 'China',
      city: 'Beijing',
      landmark: 'The great wall of China',
      latitude: 39.7833,
      longitude: 116.0648,
    ),
    TravelLocation(
      country: 'Egypt',
      city: 'El Cairo',
      landmark: 'The Pyramids',
      latitude: 30.033,
      longitude: 31.233,
    ),
    TravelLocation(
      country: 'Mexico',
      city: 'Mexico City',
      landmark: 'Capital',
      latitude: 19.4326,
      longitude: -99.1332,
    ),
    TravelLocation(
      country: 'Mexico',
      city: 'Riviera maya',
      landmark: 'Chichen itza',
      latitude: 20.30,
      longitude: -87.14,
    ),
    TravelLocation(
      country: 'Argentina',
      city: 'Buenos aires',
      landmark: 'Colon theatre',
      latitude: -34.6037,
      longitude: -58.3816,
    ),
    TravelLocation(
      country: 'Russia',
      city: 'Sanint Petersburg',
      landmark: 'Mariinsky-teatret',
      latitude: 59.97,
      longitude: 30.3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
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
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.emoji_people),
            tooltip: 'Friend list',
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            /*Text(
              'Choose travel location',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
            ),*/
            SizedBox(
              height: 560,
              width: double.maxFinite,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: LatLng(0, 0),
                  initialZoom: 2.0,
                  minZoom: 1.0,
                  maxZoom: 50.0,
                  cameraConstraint: CameraConstraint.contain(
                    bounds: LatLngBounds(LatLng(-90, -180), LatLng(90, 180)),
                  ), //this is so the user cant go outside the map size
                  initialCameraFit: CameraFit.insideBounds(
                    bounds: LatLngBounds(LatLng(-90, -180), LatLng(90, 180)),
                  ),
                  keepAlive: true,
                  interactionOptions: InteractionOptions(
                    enableScrollWheel: true,
                  ),
                ),

                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.hannimals.geografiapp',
                  ),
                  MarkerLayer(
                    markers: travelSpots.map((spot) {
                      return Marker(
                        point: LatLng(
                          spot.latitude,
                          spot.longitude,
                        ), //this is where the marker is placed
                        width: 60,
                        height: 60,
                        child: GestureDetector(
                          //this makes it possible to click on the marker
                          onDoubleTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                //this is the popup that appears when clicking the marker
                                title: Text(spot.city),
                                content: Text(
                                  'Welcome to ${spot.city}, ${spot.country}!\n\n'
                                  'Main landmark: ${spot.landmark}\n\n'
                                  'Ready for a virtual tour?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        //shows a little message at the bottom of the screen
                                        context,
                                      ).showSnackBar(
                                        // this is the message that appears when pressing tour
                                        SnackBar(
                                          content: Text(
                                            'Starting Virtual tour...',
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text('Tour'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Icon(
                            //this is what the marker looks like
                            Icons.location_pin,
                            color: Colors.red,
                            size: 50,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
          // lav map ting (open streetmap -> flutter map)
          // lav en liste af lande og for hver land lav at den indeholder de mest kendte byer og landmarker
          //
        ),
      ),
    );
  }
}
