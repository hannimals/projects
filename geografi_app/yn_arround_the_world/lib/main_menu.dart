//settings, view map, view my character, friend list
import 'package:flutter/material.dart';
import 'package:yn_arround_the_world/map.dart';
import 'package:yn_arround_the_world/settings.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  String initialText = 'Welcome! whats your name?';
  String usersName = '';
  final TextEditingController _namefielcontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      initialText;
    });
    super.initState();
  }

  @override
  void dispose() {
    _namefielcontroller.dispose();
    super
        .dispose(); //the dispose function unsuscribes from connections and listeners so our apps memory is better
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 1.0,
        backgroundColor: Colors.blue,
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
                MaterialPageRoute(builder: (context) => GeografiApp()),
              );
            },
            icon: Icon(Icons.public),
            tooltip: 'Map',
          ),
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_bag),
            tooltip: 'Shop',
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat),
            tooltip: 'Chat with friends',
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Dialog(
                  alignment: AlignmentGeometry.bottomCenter,

                  child: Form(
                    //The Form widget in Flutter is used to build a form, and it comes with built-in validation tools.
                    key: _formkey,
                    child: Column(
                      mainAxisSize: MainAxisSize
                          .min, //so it ocupies as little space as posible
                      children: [
                        Text(
                          initialText,
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            width: double.infinity,
                            child: Text(
                              'Im Hirata nice to meet you! let me show you around here. This is the main menu, here you can decide to customize your avatar, chat with your newly found friends by pressing on your global friend list... Or take a tour to the map window to make more friends!! good luck consider me as your first friend, you can find me in your friend list whenever you want to chat.',
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
                              TextFormField(
                                controller:
                                    _namefielcontroller, // this is to validate input
                                cursorHeight: 2.0,
                                cursorWidth: 2.0,

                                cursorColor: Colors.blue,

                                maxLength: 20,
                                decoration: InputDecoration(
                                  labelText: 'Enter your name',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                              ),

                              TextButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    // if the userinput isnt null

                                    setState(() {
                                      String usersName =
                                          _namefielcontroller.text;
                                      initialText =
                                          'Well $usersName i think you are ready to go';
                                    });
                                  }
                                },
                                child: Text('Next'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    //idk if (readerText == readerFirstexplanaiton){do nothing} else {readerText = readerFirstexplanaiton}
                                  });
                                },
                                child: Text('Back'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
