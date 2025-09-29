class HourlyWeather {
  final int dt;
  final String temp;
  final double feelsLike;
  final int humidity;
  final String description;
  final String icon;

  HourlyWeather({
    required this.dt,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.description,
    required this.icon,
  });

  factory HourlyWeather.fromJson(Map<String, dynamic> json) {
    return HourlyWeather(
      dt: json['dt'],
      temp: (json['main']['temp'] as num).toInt().toString(),
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }

  String get hour {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
    return dateTime.hour.toString().padLeft(2, '0');
  }
}
