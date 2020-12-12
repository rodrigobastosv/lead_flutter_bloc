import 'package:flutter/material.dart';

class TemperatureResult extends StatelessWidget {
  const TemperatureResult({
    Key key,
    this.location,
    this.temperature,
  }) : super(key: key);

  final String location;
  final String temperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        Text(
          location,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          temperature,
          style: TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
