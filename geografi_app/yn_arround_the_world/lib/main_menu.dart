//settings, view map, view my character, friend list

import 'package:flutter/material.dart';
import 'map.dart';
import 'settings.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _step = 0;
  String usersName = '';
  final TextEditingController _namefielcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late final List<String> _tutorialDialogs;
  @override
  void initState() {
    super.initState();
    _tutorialDialogs = [
      'Welcome! whats your name?',
      'Nice to meet you \$user, welcome to planet earth',
      'let me show you around here.',
      'This is the main menu, here you can decide to customize your avatar by pressing the account button', //if readerText == TutorialDilogs[2] disable all icons ecxept for account
      'You can also acsses your newly found friends by pressing on your global friend list',
      'To start press the Earth',
    ];
  }

  @override
  void dispose() {
    _namefielcontroller.dispose();
    super.dispose();
    //the dispose function unsuscribes from connections and listeners so our apps memory is better
  }

  String get _currentText {
    if (_step >= _tutorialDialogs.length) return '';
    String text = _tutorialDialogs[_step];
    if (_step >= 1) {
      text = text.replaceAll('\$user', usersName);
    }
    return text;
  }

  // hide input after name is set (step > 0)
  bool get _showNameInput => _step == 0;

  // hide whole dialog after last step
  bool get _showDialog => _step < _tutorialDialogs.length;

  void _nextDialog() {
    //this runs on onPressed: 'Next >'
    if (_step == 0) {
      if (_formkey.currentState!.validate()) {
        setState(() {
          usersName = _namefielcontroller
              .text // if the form isnt valid yet deete the spacing in the user name and allow the dialog change
              .trim(); //the trim removes space from the input
          _step++;
        });
      } else if (_step < _tutorialDialogs.length - 1) {
        setState(() {
          _step++;
        });
      }
    } else {
      setState(() {
        _step++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 1.0,
        title: const Text(
          'y/n arround the world',
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
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('not available yet')),
              );
            },
            icon: Icon(Icons.shopping_bag),
            tooltip: 'Shop',
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('not available yet')),
              );
            },
            icon: Icon(Icons.person),
            tooltip: 'My account',
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/tours/bg0.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            alignment: Alignment(0, 0),
            child: GestureDetector(
              child: ClipOval(
                child: Image.asset(
                  'assets/tours/globe.webp',
                  width: 400,
                  height: 400,
                  fit: BoxFit.cover,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GeografiApp()),
                );
              },
            ),
          ),
          if (_showDialog) //so we only see the dialog in the tutorial
            SafeArea(
              child: SizedBox(
                height: 650,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Dialog(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
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
                                width: double.maxFinite,
                                child: Text(_currentText),
                              ),
                            ),
                            Divider(
                              thickness: 0.8,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                textDirection: TextDirection.ltr,
                                children: [
                                  if (_showNameInput)
                                    //The Form widget in Flutter is used to build a form, and it comes with built-in validation tools.
                                    Form(
                                      key: _formkey,
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 9.0,
                                        ),
                                        child: SizedBox(
                                          height: 50,
                                          width: 250,
                                          child: TextFormField(
                                            controller:
                                                _namefielcontroller, // this is to validate input
                                            cursorHeight: 2.0,
                                            cursorWidth: 2.0,

                                            cursorColor: Theme.of(
                                              context,
                                            ).colorScheme.primary,

                                            maxLength: 20,
                                            decoration: InputDecoration(
                                              focusedBorder: InputBorder.none,

                                              labelText: 'Enter your name',
                                              labelStyle: TextStyle(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.primary,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 0.5,
                                                  color: Theme.of(
                                                    context,
                                                  ).colorScheme.primary,
                                                ),
                                              ),
                                            ),
                                            validator: (value) {
                                              //we validate input here
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'Please enter your name';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (_showNameInput)
                                    const SizedBox(width: 600),
                                  if (_step > 0)
                                    TextButton(
                                      onPressed: () => setState(() => _step--),

                                      child: Text('< Back'),
                                    ),

                                  TextButton(
                                    onPressed: _nextDialog,
                                    child: Text(
                                      _step < _tutorialDialogs.length - 1
                                          ? 'Next >'
                                          : 'Got it!',
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
            ),
        ],
      ),
    );
  }
}
