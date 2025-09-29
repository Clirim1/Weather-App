import 'package:flutter/material.dart';
import 'package:weather_app/data/models/weather.dart';

class WeatherInfoCard extends StatelessWidget {
  final Weather weather;
  const WeatherInfoCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 15),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            getWeatherInfoItem(
              'assets/icons/wind.png',
              "${weather.windSpeed} m/s",
              "Wind",
            ),
            getWeatherInfoItem(
              'assets/icons/humidity.png',
              "${weather.humidity}%",
              "Humidity",
            ),
            getWeatherInfoItem(
              'assets/icons/rain.png',
              "${weather.rainProbability}%",
              "Rain",
            ),
          ],
        ),
      ),
    );
  }

  Widget getWeatherInfoItem(String iconPath, String lable, String description) {
    return Column(
      children: [
        Image.asset(iconPath, width: 24, height: 24),
        SizedBox(height: 8),
        Text(
          lable,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.blueGrey.shade600,
          ),
        ),
      ],
    );
  }
}
