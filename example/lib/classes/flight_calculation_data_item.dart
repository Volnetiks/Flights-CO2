import 'package:flutter/material.dart';

class FlightCalculationDataItem extends StatelessWidget {
  const FlightCalculationDataItem({super.key, required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 13.0, color: Colors.black54)
        ),
        Text(
          body,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        )
      ]
    );
  }
}