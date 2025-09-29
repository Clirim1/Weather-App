import 'hourly_weather.dart';

class WeatherForecast {
  final List<HourlyWeather> hourly;

  WeatherForecast({required this.hourly});

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    final now = DateTime.now();
    final next24 = now.add(Duration(hours: 24));

    final filteredHourly = (json['list'] as List)
        .map((item) => HourlyWeather.fromJson(item))
        .where((h) {
          final dateTime = DateTime.fromMillisecondsSinceEpoch(h.dt * 1000);
          return dateTime.isAfter(now) && dateTime.isBefore(next24);
        })
        .toList();

    return WeatherForecast(hourly: filteredHourly);
  }
}
