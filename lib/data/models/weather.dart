import 'package:intl/intl.dart';

class Weather {
  final String? city;
  final String temperature;
  final String description;
  final String mainDescription;
  final String icon;
  final double windSpeed;
  final int humidity;
  final int rainProbability;
  final DateTime? date;
  final String? minTemp;
  final String? maxTemp;
  final String? dayTemp;

  Weather({
    required this.temperature,
    required this.description,
    required this.mainDescription,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
    required this.rainProbability,
    this.city,
    this.date,
    this.minTemp,
    this.maxTemp,
    this.dayTemp,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      city: json["name"],
      temperature: (json["main"]["temp"] as num).toInt().toString(),
      mainDescription: json["weather"][0]["main"],
      description: json["weather"][0]["description"],
      icon: json["weather"][0]["icon"],
      windSpeed: (json["wind"]["speed"] as num).toDouble(),
      humidity: (json["main"]["humidity"] as num).toInt(),
      rainProbability: json.containsKey("rain")
          ? ((json["rain"]["1h"] ?? json["rain"]["3h"]) as num?)?.round() ?? 100
          : 0,
    );
  }

  factory Weather.fromDailyJson(Map<String, dynamic> json) {
    final weatherInfo = (json['weather'] as List).first;

    return Weather(
      temperature: (json['main']['temp'] as num).toInt().toString(),
      mainDescription: weatherInfo['main'],
      description: weatherInfo['description'],
      icon: weatherInfo['icon'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      humidity: (json['main']['humidity'] as num).toInt(),
      rainProbability: ((json['pop'] ?? 0) * 100).round(),
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
      minTemp: (json['main']['temp_min'] as num).toInt().toString(),
      maxTemp: (json['main']['temp_max'] as num).toInt().toString(),
      dayTemp: (json['main']['temp'] as num).toInt().toString(),
    );
  }

  String get dayName =>
      date != null ? DateFormat('E').format(date!.toLocal()) : "";

  Weather copyWith({
    String? city,
    String? temperature,
    String? description,
    String? mainDescription,
    String? icon,
    double? windSpeed,
    int? humidity,
    int? rainProbability,
    DateTime? date,
    String? minTemp,
    String? maxTemp,
    String? dayTemp,
  }) {
    return Weather(
      city: city ?? this.city,
      temperature: temperature ?? this.temperature,
      description: description ?? this.description,
      mainDescription: mainDescription ?? this.mainDescription,
      icon: icon ?? this.icon,
      windSpeed: windSpeed ?? this.windSpeed,
      humidity: humidity ?? this.humidity,
      rainProbability: rainProbability ?? this.rainProbability,
      date: date ?? this.date,
      minTemp: minTemp ?? this.minTemp,
      maxTemp: maxTemp ?? this.maxTemp,
      dayTemp: dayTemp ?? this.dayTemp,
    );
  }
}
