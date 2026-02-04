// when press tour navigate to tour window
//baggrund billede + karakter (2d billede, renpy sprite + dialog)
// take city/country parameter and load assets from there + make custom dialog from there.

import 'package:flutter/material.dart';
import 'map.dart';
import 'quizz.dart';

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
  late List<String> _backgroundPaths;
  late List<String> _dialogs;
  late List<bool> _showCharacter;
  late String _characterName;
  late String _fontFamily;
  final List<String> _dialogsEgypt = [
    "You just landed in the bustling streets of Cairo.",
    'A faint silhouette of a woman walks towards you.',
    "Her eyes are glistening and piercing yours with an amber yellow. She looks fierce, intimidating and...  Gorgeous",
    "Ahlan! Are you Y/N?",
    "Ms. Universe told me so much about you, let me show you around in Cairo!",
    'We are currently in what we call “The Old Town of Cairo”.',
    'This specific bazar is called Khan El Kalili Market and is one of UNESCO World Heritage Sites.',
    'Its not certain when it was established, but scholars say it was likely between year 1382 and 1389 CE.',
    'This means it was established around 420 years after Cairo, making it an integral part of the city.',
    '....Anyways, sorry for that info dump. The food they sell here is my favourite',
    'I figured while we are in the area, we could go to grab some food! Just wait a second... ill get you something.',
    'You watch Sharifa slowly disappear in a crowd of people, hoping she will come back sooner than later...', //  12 change Character name to narrator if Egypt_dialog_list[this one] change name
    'Some time passes.', //13 narrator
    'Im back! I bought you my favorite, Koshari!',
    'It contains rice, lentils, and macaroni, topped with a tangy tomato sauce, crispy fried onions, and chickpeas.',
    'Its completely vegan and happens to be the national food... I hope you like it!',
    'Also, dont worry about paying... thats Egyptian hospitality for you',
    'Im so full now...',
    'Do you know what is good after a big meal?',
    'A long walk! Lets get going.',
    'After walking till your feet ache, you finally reach your next destination.', //narrator 21
    'Look where i brought you.',
    'The Great Pyramids of Giza!!!',
    'Im sure everyone knows that The Great Pyramids of Giza is one of the 7 new world wonders.',
    'But I bet that you didnt know that The Great Pyramids of Giza is the only surviving ancient world wonder.',
    'Egypt is also home to another ancient world wonder being the Lighthouse of Alexandria.', // image asset
    'Another popular landmark is the Sphinx, which is nearby.', //image asset
    'It kind of looks like a cat, dont you think?',
    'Its actually a mythological creature with the head of a human and the body of a lion.',
    'Cats do serve of great importance in Egypt tho.',
    'Back when the pharaohs were alive cats were revered as sacred, magical, and protective creatures, that was closely intertwined with daily life, religion, and the afterlife.',
    'That probably explains the stray cat population now...',
    'Its getting late now, maybe we should head back to the city. ',
    'Sharifa hails a taxi and the two of you drive towards the Nile.', //narrator
    'The traffic was crazy on our way back.',
    'It makes sense considering that most of out 119 million population lives near the Nile...',
    'Effectively 95% of the country is a desert. ',
    'And water is very important for human life to thrive!',
    'The Nile doesnt just suffice water for Egypt tho.',
    'It flows across 11 different countries in Africa, making it the longest river in the world.',
    'I thought a fitting last gift would be a trip around the Nile.',
    'Lets get on!',
    'The night passes on as you and Shrifa had a fun and exciting adventure for the day...',
    'Ms. Universe is very excited to hear everything you learned...',
  ];
  final List<String> _dialogsMexico = [
    'In a crowd of people a big muscular handsome man stands out ',
    'Hi you must be y/n. My name is Alejandro Antonio Martinez Acevedo. But you can just call me Alejo ',
    'Welcome to Mexico City. The capital of Mexico ',
    'Im from Sinaloa, one of the northeren states of Mexico. You can see it on my clothing, like my belt. ',
    'This belt is called a charro belt. Charro means a Mexican horseman or cowboy',
    'Which leads us to my favorite part of this trip... lets go follow me!.',
    'This is called Charrería. It is Mexicos national sport',
    'This is so exciting ¡Ajúa!',
    'This is also my favorite sport since i loooove horses',
    'I see the game is coming to an end now. Oh wait what is that sound...',
    'Its a marichi! Mariachis are traditional mexican bands. Their music is played during celebratins of special occassions ',
    'That was so fun. However were just getting started. Lets go to our next location ',
    'this is Chichen Itza. One of the 7 world wonders.',
    'Chichen Itza was build between the 7th and 13th centuries by the maya civilazations',
    'Fun fact about the maya people. They were the first to use cacao. They used it for sacred and medicinal purposes.',
    'I hold a lot of pride in that. Because i also loooove chocolate!',
    'Anyways. Lets to to our next location. ',
    'Tadaaaaa. This is Pico de Orizaba, an active volcano and the tallest mountain in Mexico',
    'It is located right on the boarder of the states Veracruz and Puebla. It raises 5.6 km above sea level.',
    'And this beings our travels to an end.',
  ];
  final List<String> _dialogsChina = [
    'Somehow you made it on top of... The Great Wall of China?',
    'You look around in confusion, when you suddenly see a short statured woman run towards you.',
    'WOAH! Ni hao, Im so sorry for being late!',
    'Ms. Universe had arranged for us meet at the part called Badaling, but unfortunately she made a few miscalculations..',
    'My name? Oh, how rude of me!',
    'My name is Lou Yan. Im very pleased to finally meet you Y/N.',
    'We are currently standing on The Great Wall of China. This is one of the 7 world wonders of the world',
    'The Wall strikes over 20.000 km! and took over 2000 years to build',
    'But right now we are standing on the part og the wall, that is located in Beijing which also happens to be the capital city of China ',
    'oh yeah I almost forgot. Ms Univers bought us traintickts to expeinces shanghais georgeus river ',
    'So let us get going!',
    'Welcome to Shanghai. The city with many skyscrapers and the tallest building in china being the Shanghai Tower. ',
    'Shanghai is also the the mouth of Yangtze river. The longest river in China, striking 6300km over the country  ',
    'Funny thing. My name means beautiful Yan from the Luo river which is a tributary of the Yangtze river. ',
    'You might have figured if china holds place to this long yangtze river and the longest wall in the world. China is pretty big country.',
    'Therefor we have 5 different time zones across the country.',
    'Speaking of time. My time as your tour guide is sadly comming to its end',
    'I wish you good luck in your test and great travels through out the other countries',
    'Oh wait. I almost forgot to mention... ',
    'This traditional clothing i am wearing is called a qibao, and the styling happen to be shanghai style ',
    'Now i can send you off fully ready ready for your test ',
    'Bye y/n. Good luck and great travels! Zàijiàn(再见)',
  ];

  @override
  void initState() {
    super.initState();
    switch (widget.country.toLowerCase()) {
      case 'egypt':
        _dialogs = _dialogsEgypt;
        _characterName = 'Sharifa';
        _fontFamily = 'Quintessential';
        _backgroundPaths = List.generate(_dialogs.length, (i) => 'bg1.png');
        _backgroundPaths[12] = 'bg13.png';
        _backgroundPaths[14] = 'bg15.png';
        _backgroundPaths[15] = 'bg15.png';
        _backgroundPaths[20] = 'bg16.png';
        _backgroundPaths[21] = 'bg17.png';
        _backgroundPaths[22] = 'bg18.png';
        _backgroundPaths[23] = 'bg18.png';
        _backgroundPaths[24] = 'bg18.png';
        _backgroundPaths[25] = 'bg19.png';
        _backgroundPaths[26] = 'bg20.png';
        _backgroundPaths[27] = 'bg20.png';
        _backgroundPaths[28] = 'bg20.png';
        _backgroundPaths[29] = 'bg18.png';
        _backgroundPaths[30] = 'bg18.png';
        _backgroundPaths[31] = 'bg18.png';
        _backgroundPaths[32] = 'bg17.png';
        _backgroundPaths[33] = 'bg209.png';
        _backgroundPaths[34] = 'bg21.png';
        _backgroundPaths[35] = 'bg22.png';
        _backgroundPaths[36] = 'bg22.png';
        _backgroundPaths[37] = 'bg22.png';
        _backgroundPaths[38] = 'bg22.png';
        _backgroundPaths[39] = 'bg22.png';
        _backgroundPaths[40] = 'bg23.png';
        _backgroundPaths[41] = 'bg21.png';
        _backgroundPaths[42] = 'bg25.png';
        _showCharacter = List.generate(_dialogs.length, (_) => true);
        _showCharacter[0] = false;
        _showCharacter[1] = false;
        _showCharacter[2] = false;
        _showCharacter[11] = false;
        _showCharacter[12] = false;
        _showCharacter[14] = false;
        _showCharacter[15] = false;
        _showCharacter[20] = false;
        _showCharacter[33] = false;
        _showCharacter[42] = false;
        break;

      case 'mexico':
        _dialogs = _dialogsMexico;
        _characterName = 'Alejo';
        _fontFamily = 'Mynerve';
        _backgroundPaths = List.filled(_dialogs.length, 'bg0.png');
        _backgroundPaths[6] = 'bg1.png';
        _backgroundPaths[8] = 'bg1.png';
        _backgroundPaths[9] = 'bg1.png';
        _backgroundPaths[10] = 'bg1.png';
        _backgroundPaths[11] = 'bg1.png';
        _backgroundPaths[12] = 'bg1.png';
        _backgroundPaths[13] = 'bg2.png';
        _backgroundPaths[14] = 'bg2.png';
        _backgroundPaths[15] = 'bg2.png';
        _backgroundPaths[16] = 'bg2.png';
        _backgroundPaths[17] = 'bg2.png';
        _backgroundPaths[18] = 'bg3.png';
        _backgroundPaths[19] = 'bg3.png';
        //_backgroundPaths[20] = 'bg3.png';

        // Customize per step when you have more assets
        _showCharacter = List.generate(_dialogs.length, (_) => true);
        _showCharacter[0] = false; // Intro crowd scene
        break;

      case 'china':
        _dialogs = _dialogsChina;
        _characterName = ' Luo Yan (洛妍)';
        _fontFamily = 'Special Elite';
        _backgroundPaths = List.filled(_dialogs.length, 'bg1.jpg');
        _backgroundPaths[11] = 'bg2.png';
        _backgroundPaths[12] = 'bg2.png';
        _backgroundPaths[13] = 'bg2.png';
        _backgroundPaths[14] = 'bg2.png';
        _backgroundPaths[15] = 'bg2.png';
        _backgroundPaths[16] = 'bg2.png';
        _backgroundPaths[17] = 'bg2.png';
        _backgroundPaths[18] = 'bg2.png';
        _backgroundPaths[19] = 'bg2.png';
        _backgroundPaths[20] = 'bg2.png';
        _backgroundPaths[21] = 'bg2.png';
        _showCharacter = List.generate(_dialogs.length, (_) => true);
        _showCharacter[0] = false; // Confusion on wall
        _showCharacter[1] = false;
        break;

      default:
        // Fallback
        _dialogs = ['No tour available for ${widget.country} yet.'];
        _backgroundPaths = ['bg0.jpg'];
        _showCharacter = [false];
        _characterName = 'Ms. Universe';
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheCurrentandNext();
    });
  }

  void _precacheCurrentandNext() async {
    // we create a function to load the next images beforehand to improve fluidity
    if (!mounted) return;
    precacheImage(_currentBackground, context);
    if (_isCharacterBeingShowed) {
      precacheImage(
        AssetImage('assets/tours/${widget.country.toLowerCase()}/Guide.png'),
        context,
      );
    }
    if (_step + 1 < _backgroundPaths.length) {
      final nextPath =
          'assets/tours/${widget.country.toLowerCase()}/${_backgroundPaths[_step + 1]}';
      precacheImage(AssetImage(nextPath), context);
    }
  }

  String get _currentFontFamily => _fontFamily;

  String get _currentDialogText {
    if (_step >= _dialogs.length) return '';
    return _dialogs[_step];
  }

  AssetImage get _currentBackground {
    if (_step >= _backgroundPaths.length) {
      return AssetImage('assets/tours/bg0.jpg');
    }
    final imagepath =
        'assets/tours/${widget.country.toLowerCase()}/${_backgroundPaths[_step]}';
    return AssetImage(imagepath);
  }

  bool get _isCharacterBeingShowed =>
      _step < _showCharacter.length && _showCharacter[_step];
  // && means and then so it first check the expresion on the left and then on the right
  //its only true if the left expresion is true and the _showCharacter in the specific [_step] is true

  bool get _isLastStep => _step >= _dialogs.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          //background for the city
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _currentBackground,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            height: 20,
            top: 10,
            left: 15,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.withValues(
                  alpha: 0.5,
                ), // ← your custom color
                foregroundColor: Colors.white,
                elevation: 4,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogcontext) => AlertDialog(
                    title: Text(
                      'If you exit the experience you will lose your progress',
                    ),
                    content: Text('press back to continew the tour'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogcontext);
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogcontext);
                          Navigator.pop(context);
                        },
                        child: Text('Exit'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Exit Tour'),
            ),
          ),
          //tourguide
          if (_isCharacterBeingShowed)
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              height:
                  MediaQuery.of(context).size.height *
                  0.75, //adjust asset to our flutterview size (mediaQueary.of(context))
              child: Image.asset(
                'assets/tours/${widget.country.toLowerCase()}/Guide.png',
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomRight,
              ),
            ),
          //dialog
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,

            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(16),
              color: Colors.black.withValues(alpha: 0.5),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Character name (only when character is visible)
                    if (_isCharacterBeingShowed)
                      Text(
                        _characterName,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                    const SizedBox(height: 8),

                    // Dialog text
                    SizedBox(
                      height: 60,

                      child: Text(
                        _currentDialogText,
                        style: TextStyle(
                          fontFamily: _currentFontFamily,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Buttons row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (_step > 0)
                          TextButton(
                            onPressed: () => setState(() => _step--),
                            child: const Text(
                              'Back',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            if (!_isLastStep) {
                              setState(() => _step++);
                              _precacheCurrentandNext();
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      Quizz(country: widget.country),
                                ),
                              );
                            }
                          },
                          child: Text(
                            _isLastStep ? 'End Tour → Quiz' : 'Next →',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
