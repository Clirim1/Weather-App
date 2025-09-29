import 'package:flutter/material.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/models/weather_forcase.dart';
import 'package:weather_app/presantation/widgets/small_weather_dard.dart';
import 'package:weather_app/presantation/widgets/title_text.dart';
import 'package:weather_app/presantation/widgets/weather_card.dart';
import 'package:weather_app/presantation/widgets/weather_info_card.dart';
import '../../data/models/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;
  final WeatherForecast weatherForecast;
  final List<Weather> weather5DaysList;
  final City city;
  final String degreeSymbol;
  const WeatherDisplay({
    super.key,
    required this.weather,
    required this.weatherForecast,
    required this.weather5DaysList,
    required this.degreeSymbol,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TitleText(title: "${city.name}, ${city.country}"),
          WeatherCard(weather: weather, degreeSymbol: degreeSymbol),
          WeatherInfoCard(weather: weather),
          TitleText(title: "Today", isSubtitle: true),
          getTodaysWeatherList(),
          TitleText(title: "This Week", isSubtitle: true),
          getThisWeekWeatherList(),
        ],
      ),
    );
  }

  Widget getTodaysWeatherList() {
    return Container(
      height: 125,
      margin: EdgeInsets.only(bottom: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherForecast.hourly.length,
        itemBuilder: (context, index) {
          final hourData = weatherForecast.hourly[index];
          return Container(
            padding: EdgeInsets.only(right: 3, left: index == 0 ? 20 : 3),

            alignment: Alignment.center,
            child: SmallWeatherCard(
              lable: hourData.hour,
              icon: hourData.icon,
              temperature: hourData.temp,
              degreeSymbol: degreeSymbol,
            ),
          );
        },
      ),
    );
  }

  Widget getThisWeekWeatherList() {
    return Container(
      height: 125,
      margin: EdgeInsets.only(bottom: 15),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weather5DaysList.length,
        itemBuilder: (context, index) {
          final dayData = weather5DaysList[index];
          return Container(
            padding: EdgeInsets.only(right: 3, left: index == 0 ? 20 : 3),

            alignment: Alignment.center,
            child: SmallWeatherCard(
              lable: dayData.dayName,
              icon: dayData.icon,
              degreeSymbol: degreeSymbol,
              temperature:
                  "${dayData.minTemp}$degreeSymbol - ${dayData.maxTemp}",
              isWeekData: true,
            ),
          );
        },
      ),
    );
  }
}
