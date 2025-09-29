import 'package:flutter/material.dart';

class SmallWeatherCard extends StatelessWidget {
  final String lable;
  final String icon;
  final String temperature;
  final bool isWeekData;
  final String degreeSymbol;
  const SmallWeatherCard({
    super.key,
    required this.lable,
    required this.temperature,
    required this.icon,
    required this.degreeSymbol,
    this.isWeekData = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: isWeekData ? 110 : 80,
        height: isWeekData ? 140 : 120,
        padding: EdgeInsets.all(8),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              lable,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade700,
              ),
            ),
            Image.network(
              "https://openweathermap.org/img/wn/$icon.png",
              width: 40,
              height: 40,
            ),
            Text(
              "$temperature$degreeSymbol",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
