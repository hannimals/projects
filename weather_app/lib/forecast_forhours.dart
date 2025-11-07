import 'package:flutter/material.dart';

class Houlyforecascards extends StatelessWidget {
  const Houlyforecascards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        color: const Color.fromARGB(255, 51, 51, 51),
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: const Column(
            children: [
              Text(
                '3:00',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Icon(Icons.cloud, size: 40),
              SizedBox(height: 2),
              Text('30'),
            ],
          ),
        ),
      ),
    );
  }
}
