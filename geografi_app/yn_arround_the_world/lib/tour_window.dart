// when press tour navigate to tour window
//baggrund billede + karakter (2d billede, renpy sprite + dialog)
// take city/country parameter and load assets from there + make custom dialog from there.

import 'package:flutter/material.dart';
import 'package:yn_arround_the_world/quizz.dart';

class TourWindow extends StatefulWidget {
  final String country;
  final String city;
  final String landmark;
  const TourWindow({
    super.key,
    required this.country,
    required this.city,
    required this.landmark,
  });

  @override
  State<TourWindow> createState() => _TourWindowState();
}

class _TourWindowState extends State<TourWindow> {
  int _step = 0;

  @override
  void initState() {
    //should implement state?
    _currentText;
    super.initState();
  }

  final List<String> _dialogsEgypt = [
    "You just landed in the bustling streets of Cairo.",
    'A faint silhouette of a woman walks towards you.',
    "Her eyes are glistening and piercing yours with an amber yellow. She looks fierce, intimidating and...  Gorgeous",
    "Ahlan! Are you Y/N?",
    "Ms. Universe told me so much about you, let me show you around in Cairo!",
    'We are currently in what we call “The Old Town of Cairo”.',
    'This specific bazar is called Khan El Kalili Market.',
    'the food they sell here is my favourite',
    'Now this is a very famous place; the pyramids',
    'I love how the city looks so lively at night...',
    'I think thats all',
  ];
  final List<String> _dialogsMexico = [''];
  final List<String> _dialogsChina = [
    'Somehow you made it on top of... The Great Wall of China?',
    'You look around in confusion, when you suddenly see a short statured woman run towards you.',
    'WOAH! Ni hao, Im so sorry for being late!',
    'Ms. Universe had arranged for us meet at the part called Badaling, but unfortunately she made a few miscalculations..',
    'My name? Oh, how rude of me!',
    'My name is Lou Yan. Im very pleased to finally meet you Y/N.',
    'This is the Great wall of china',
    'Follow me please'
        'Now this is the hidden city, i would say beijings main atraccion!',
  ];

  final List<AssetImage> _imageListBackgrounds = [
    AssetImage('assets/tours/{country}/bg.jpg'),
    AssetImage('assets/tours/{country}/bg1.jpg'),
    AssetImage('assets/tours/{country}/bg2.jpg'),
    AssetImage('assets/tours/{country}/bg3.jpg'),
  ];
  String get _currentText {
    if (widget.country == 'Egypt') {
      if (_step >= _dialogsEgypt.length) return '';
      String text = _dialogsEgypt[_step];
      return text;
    } else if (widget.country == 'China') {
      if (_step >= _dialogsChina.length) return '';
      String text = _dialogsChina[_step];
      return text;
    } else {
      if (_step >= _dialogsMexico.length) return '';
      String text = _dialogsMexico[_step];
      return text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background for the city
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/tours/${widget.country.toLowerCase()}/bg.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/tours/${widget.country.toLowerCase()}/TourGuide.webp',
                ),
                fit: BoxFit.fitHeight,
                alignment: AlignmentGeometry.xy(0.6, 0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
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
                            '{character name}',
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
                              _currentText,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        Divider(thickness: 0.8, color: Colors.black12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          textDirection: TextDirection.ltr,
                          children: [
                            if (_step > 0)
                              TextButton(
                                onPressed: () => setState(() => _step--),
                                child: const Text('< Back'),
                              ),
                            TextButton(
                              onPressed: () {
                                if (_currentText != '') {
                                  setState(() => _step++);
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Quizz(
                                        country: widget.country.toString(),
                                      ),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                (_currentText != '') ? 'Next >' : 'End Tour',
                              ),
                            ),
                          ],
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
