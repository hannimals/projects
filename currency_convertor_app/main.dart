/* 
Types of widgets:
statefull widget - te data can change (state changes)
stateless widget - the state is inmutable (data cannot be changed)
inherited widget 

state: data your widget may have

design systems:
material design: created by google
cupertino design: created by apple
*/

import 'package:currency_converter/currency_convertor_material_page.dart';
import 'package:flutter/material.dart'; // we are using a material design app

void main() {
  runApp(MyApp()); // app is a widget and widget is an abstract class
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // this is a short syntax of ({Key? key}) : super(key: key);
  // MyApp being const means it doesent have to be rebuild each time
  @override
  Widget build(BuildContext context) {
    //build context gives the location of the widget in the widget tree
    return MaterialApp(
      home: CurrencyConvertorMaterialPage(),
    ); //home is a property of material app
  }
}

// 12.03
