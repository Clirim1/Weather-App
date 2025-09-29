import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/data/models/weather.dart';

class WeatherCard extends StatelessWidget {
  final Weather weather;
  final String degreeSymbol;
  const WeatherCard({
    super.key,
    required this.weather,
    required this.degreeSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getCurrentDateFormatted(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black.withValues(alpha: 0.5),
                  ),
                ),
                Text(
                  weather.mainDescription,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  "${weather.temperature}$degreeSymbol",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Image.network(
              "https://openweathermap.org/img/wn/${weather.icon}@2x.png",
            ),
          ],
        ),
      ),
    );
  }

  String getCurrentDateFormatted() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("dd MMMM yyyy").format(now).toUpperCase();
    return formattedDate;
  }
}
