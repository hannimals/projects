import 'package:flutter/material.dart';

class ShoppingApp extends StatefulWidget {
  const ShoppingApp({super.key});

  @override
  State<ShoppingApp> createState() => _ShoppingAppState();
}

class _ShoppingAppState extends State<ShoppingApp> {
  final List<String> filters = const [
    'All',
    'Adidas',
    'Nike',
    'NewBalance',
    'Puma',
    'Jordan',
    'Airforce',
    'Accers',
  ];
  late String _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'New Collection',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
                  ),
                ),
                //input widget so it fills the place is given
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      icon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(50),
                        ),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                    ),
                  ),
                ), // expanded says: take as much space as posible working in all the screen sizes
              ],
            ),
            SizedBox(
              height: 50,
              child: ListView.builder(
                //so it boild the widget that is showned.
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filterlabels = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = filterlabels;
                        });
                      },
                      child: Chip(
                        side: BorderSide(
                          color: const Color.fromRGBO(245, 247, 249, 1),
                        ),
                        backgroundColor: _selectedFilter == filterlabels
                            ? Theme.of(context).colorScheme.primary
                            : Color.fromRGBO(245, 247, 249, 1),
                        label: Text(
                          filterlabels,
                          style: TextStyle(fontSize: 15),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 15.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(30),
                        ),
                      ),
                    ),
                  );
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            Placeholder(fallbackHeight: 200, fallbackWidth: double.infinity),
          ],
        ),
      ),
    );
  }
}
