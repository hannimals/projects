import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'key.dart' as webkey;

class CurrencyConvertorMaterialPage extends StatefulWidget {
  const CurrencyConvertorMaterialPage({super.key});

  @override
  State<CurrencyConvertorMaterialPage> createState() => _ConvertorPageState();
}

class _ConvertorPageState extends State<CurrencyConvertorMaterialPage> {
  //variables in this case private _
  Map<String, double> _rates = {};
  bool _isLoading = true;
  String? _errors;
  String lastupdate = '';
  final _inputcontroller = TextEditingController();
  String _selectedcurrency = 'EUR'; //the default currency to change into
  double _convertedMoney = 0.00; //default converted result when we have 0
  //String _displayvalue = '0.00';
  // API key (move to secure storage in production!)
  static final String _apiKey = webkey.webkeyF();
  static final String _apiUrl =
      'https://v6.exchangerate-api.com/v6/$_apiKey/latest/USD';

  @override
  void initState() {
    // what gets executet before the build function
    super.initState();
    _fetchRates();
    _inputcontroller.addListener(
      _onImputChanged,
    ); // make the function that will lie in our on togled in the future
  }

  Future<void> _fetchRates() async {
    setState(() {
      _isLoading = true;
      _errors = null;
    });

    //we make a try and catch block for handling errors

    try {
      final response = await http.get(Uri.parse(_apiUrl));

      if (response.statusCode != 200) {
        throw Exception('Failed to load valuta rates: ${response.statusCode}');
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      //jsondecode encodes JSON objects to strings and decodes strings to JSON objects. here we use it to get our rates in the desired data
      if (data['result'] != 'success') {
        throw Exception('API error: ${data['error-type'] ?? 'Unknown'}');
      }
      lastupdate = data['time_last_update_utc'].toString();
      if (kDebugMode) {
        print('last updatee: $lastupdate');
      }
      setState(() {
        _rates = Map<String, double>.from(data['conversion_rates']);
        _isLoading = false;
        if (_rates.isNotEmpty && !_rates.containsKey(_selectedcurrency)) {
          _selectedcurrency = _rates.keys.first;
        }
        _onImputChanged(); //update conversion
      });
    } catch (e) {
      setState(() {
        _errors = 'after catch Error: ${e.toString()}';
        _isLoading = false;
        if (kDebugMode) {
          print(_errors);
        }
      });
    }
  }

  void _onImputChanged() {
    final outputString = _inputcontroller.text;
    if (outputString.isEmpty) {
      setState(() => _convertedMoney == 0.0);
      return;
    }
    final usd = double.tryParse(
      outputString,
    ); // we transform the string input to a nullable double
    if (usd == null) {
      setState(() => _convertedMoney == 0.0);
      return;
    }
    final rate = _rates[_selectedcurrency];
    if (rate != null) {
      setState(() => _convertedMoney = usd * rate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white30,
        style: BorderStyle.solid,
        width: 2.0,
      ),
      borderRadius: BorderRadius.all(Radius.circular(60)),
    );

    Text displaytext = Text(
      '$_selectedcurrency = ${_convertedMoney.toStringAsFixed(2)}',
      style: TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 42, 42, 42),
        title: Text('Currency Convertor'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white70,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 10.0),
              child: displaytext,
            ),

            /*Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 30.0,
              ),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    // we want to change our displaytext so we need to inform the program that the state value of _displayvalue has changed
                    _displayvalue =
                        '$_selectedcurrency = ${_convertedMoney.toStringAsFixed(2)}'; // two decimals
                  });
                  if (kDebugMode) {
                    print('button pressed');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white54,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),*/
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 0.20,
                horizontal: 30.0,
              ),
              child: TextField(
                controller: _inputcontroller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText:
                      'enter your value in USD ', // hintText so the label text dissapears once we start typing
                  hintStyle: TextStyle(
                    color: const Color.fromARGB(132, 255, 255, 255),
                    fontSize: 20,
                  ),
                  prefixIcon: Icon(Icons.monetization_on, size: 40),
                  prefixIconColor: Colors.grey,
                  focusedBorder: border,
                  enabledBorder:
                      border, //so the border stays the same while we type and when not
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true, // so it takes decimal
                  signed: true, // so it takes minus
                ), // we specify so it takes numbers
              ),
            ),

            //text field alows us to put user input
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 30.0,
              ),
              child: DropdownButton<String>(
                icon: Icon(
                  Icons.arrow_downward,
                  textDirection: TextDirection.ltr,
                ),

                value: _selectedcurrency,
                dropdownColor: Colors.black26,
                isExpanded: true,
                hint: Text(
                  'Select Currency',
                  style: TextStyle(color: Colors.white70),
                ),

                items: _rates.keys.map((currency) {
                  return DropdownMenuItem(
                    value: currency,
                    child: Text(
                      currency,
                      style: TextStyle(color: Colors.white70),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedcurrency = value;
                      _onImputChanged();
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_errors != null)
              Text(
                _errors!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            /*else if (_rates.isNotEmpty)
              Text(
                '${_inputcontroller.text.isEmpty ? 0 : _inputcontroller.text} USD = ${_convertedMoney.toStringAsFixed(2)} $_selectedcurrency',
                style: Theme.of(context).textTheme.headlineMedium,
              ),*/
            ElevatedButton(
              onPressed: _fetchRates,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(137, 63, 63, 63),
                foregroundColor: Colors.white,
                minimumSize: Size(50, 50),
                elevation: 3,
              ),
              child: const Text(
                'refresh rates',
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'last update: $lastupdate',
                style: TextStyle(color: Colors.white60),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputcontroller.removeListener(_onImputChanged);
    _inputcontroller.dispose();
    super.dispose();
  }
}
