import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tour_window.dart'; // Import other views as needed
import 'settings.dart';
import 'marker_blueprint.dart'; // For TravelLocation

class GeografiApp extends StatefulWidget {
  const GeografiApp({super.key});

  @override
  State<GeografiApp> createState() => _GeografiAppState();
}

class _GeografiAppState extends State<GeografiApp> {
  int _step = 0;
  late SharedPreferences _prefs;
  final List<String> _tutorialDialogs = [
    'Great job, you can now select the destination you want to travel to...',
    'But first of all!',
    'Good luck making friends out there. Just remember that i was your first.',
    'OH! Wait...! Did i forget to tell you my name?',
    'You can simply call me Ms Universe.',
  ];

  @override
  void initState() {
    _step = 0;
    super.initState();
    _loadTutorialState();
  }

  Future<void> _loadTutorialState() async {
    _prefs = await SharedPreferences.getInstance();
    bool tutorialCompleted = _prefs.getBool('mapTutorialCompleted') ?? false;
    if (tutorialCompleted) {
      setState(() {
        _step = _tutorialDialogs.length;
      });
    }
  }

  Future<void> _saveTutorialCompleted() async {
    await _prefs.setBool('mapTutorialCompleted', true);
  }

  String get _currentDialog {
    if (_step >= _tutorialDialogs.length) {
      return '';
    }
    String text = _tutorialDialogs[_step];
    return text;
  }

  bool get _showDialog => _step < _tutorialDialogs.length;

  // controller for imperative camera moves; use this to move/animate the
  // camera to a constrained position before changing MapOptions.
  final MapController _mapController = MapController();

  // Ensure the current camera is valid for `newOptions` by constraining it
  // with `newOptions.cameraConstraint` and moving the map if necessary.
  // Call this before rebuilding `FlutterMap` with options that change
  // bounds/zoom limits to avoid the "MapCamera is no longer within the
  // cameraConstraint after an option change" exception.
  void _ensureCameraMatchesConstraint(MapOptions newOptions) {
    try {
      final currentCamera = _mapController.camera;
      final constrainedCamera = newOptions.cameraConstraint.constrain(
        currentCamera,
      );
      if (constrainedCamera == null) return;

      final center = constrainedCamera.center;
      final zoom = constrainedCamera.zoom;
      if (constrainedCamera != currentCamera) {
        _mapController.move(center, zoom);
      }
    } catch (e) {
      // If the controller isn't ready or API differs, ignore safely.
    }
  }

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
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('not available yet')),
              );
            },
            icon: Icon(Icons.emoji_people),
            tooltip: 'Friend list',
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 550,
                  width: double.maxFinite,
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialCenter: LatLng(0, 0),
                      initialZoom: 2.0,
                      minZoom: 1.0,
                      maxZoom: 11.0,
                      cameraConstraint: CameraConstraint.contain(
                        bounds: LatLngBounds(
                          LatLng(-90, -180),
                          LatLng(90, 180),
                        ),
                      ), //this is so the user cant go outside the map size

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
                                  builder: (dialogcontext) => AlertDialog(
                                    //this is the popup that appears when clicking the marker
                                    title: Text(spot.city),
                                    content: Text(
                                      'Welcome to ${spot.city}, ${spot.country}!\n\n'
                                      'Main landmark: ${spot.landmark}\n\n'
                                      'Ready for a virtual tour?',
                                    ),
                                    actions: [
                                      TextButton(
                                        child: const Text('close'),
                                        onPressed: () =>
                                            Navigator.pop(dialogcontext),
                                      ),
                                      TextButton(
                                        child: const Text('Tour'),
                                        onPressed: () {
                                          // if city is in city_list: load image asset folder of city

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TourWindow(
                                                country: spot.country,
                                                city: spot.city,
                                                landmark: spot.landmark,
                                              ),
                                            ),
                                          );
                                          ScaffoldMessenger.of(
                                            context, //shows a little message at the bottom of the screen
                                          ).showSnackBar(
                                            // this is the message that appears when pressing tour
                                            const SnackBar(
                                              content: Text(
                                                'Starting Virtual tour...',
                                              ),
                                            ),
                                          );
                                        },
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
            ),
          ),
          if (_showDialog)
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Dialog(
                      alignment: AlignmentGeometry.bottomCenter,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '???',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 60,
                              child: Text(
                                _currentDialog,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Divider(thickness: 0.8, color: Colors.black12),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              textDirection: TextDirection.ltr,
                              children: [
                                if (_step > 0)
                                  TextButton(
                                    onPressed: () => setState(() => _step--),
                                    child: const Text('Back'),
                                  ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _step++;
                                    });
                                    if (_step >= _tutorialDialogs.length) {
                                      _saveTutorialCompleted();
                                    }
                                  },

                                  child: Text(
                                    _step < _tutorialDialogs.length - 1
                                        ? 'Next'
                                        : 'End Tutorial',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
