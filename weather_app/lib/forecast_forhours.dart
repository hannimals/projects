import 'package:flutter/material.dart';

class Houlyforecascards extends StatelessWidget {
  final String time;
  final String temp;
  final IconData icon;
  const Houlyforecascards({
    super.key,
    required this.time,
    required this.temp,
    required this.icon,
  });

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
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Icon(icon, size: 40),
              const SizedBox(height: 2),
              Text(temp),
            ],
          ),
        ),
      ),
    );
  }
}
