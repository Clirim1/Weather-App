import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models/city.dart';
import 'models/weather.dart';
import 'models/weather_forcase.dart';

class WeatherApi {
  static const String _baseUrl = "https://api.openweathermap.org";
  static const String _apiKey = "637785964c3544f72da9f85d82822892";

  Future<dynamic> _get(String endpoint, {Map<String, String>? params}) async {
    final uri = Uri.parse("$_baseUrl$endpoint").replace(
      queryParameters: {
        "appid": _apiKey,
        "lang": "en",
        if (params != null) ...params,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception(
        "Request failed [${response.statusCode}]: ${response.body}",
      );
    }

    return jsonDecode(response.body);
  }

  Future<List<City>> searchCities(String query) async {
    if (query.trim().isEmpty) return [];

    final data = await _get(
      "/geo/1.0/direct",
      params: {"q": query, "limit": "5"},
    );

    return (data as List).map((e) => City.fromJson(e)).toList();
  }

  Future<Weather> fetchWeather(
    double lat,
    double lon, {
    bool metric = true,
  }) async {
    final data = await _get(
      "/data/2.5/weather",
      params: {
        "lat": "$lat",
        "lon": "$lon",
        "units": metric ? "metric" : "imperial",
      },
    );

    return Weather.fromJson(data as Map<String, dynamic>);
  }

  Future<WeatherForecast> fetchHourlyWeather(
    double lat,
    double lon, {
    bool metric = true,
  }) async {
    final data = await _get(
      "/data/2.5/forecast",
      params: {
        "lat": "$lat",
        "lon": "$lon",
        "units": metric ? "metric" : "imperial",
      },
    );

    return WeatherForecast.fromJson(data as Map<String, dynamic>);
  }

  Future<List<Weather>> fetch5DayForecastDaily(
    double lat,
    double lon, {
    bool metric = true,
  }) async {
    final data = await _get(
      "/data/2.5/forecast",
      params: {
        "lat": "$lat",
        "lon": "$lon",
        "units": metric ? "metric" : "imperial",
      },
    );

    final list = (data as Map<String, dynamic>)["list"] as List;

    final Map<String, List<Map<String, dynamic>>> grouped = {};
    for (final item in list) {
      final date = DateTime.fromMillisecondsSinceEpoch(
        item["dt"] * 1000,
      ).toLocal();
      final key = "${date.year}-${date.month}-${date.day}";
      grouped.putIfAbsent(key, () => []).add(item as Map<String, dynamic>);
    }

    return grouped.entries.map((entry) {
      final items = entry.value;

      final temps = items.map((i) => (i['main']['temp'] as num).toDouble());
      final minTemps = items.map(
        (i) => (i['main']['temp_min'] as num).toDouble(),
      );
      final maxTemps = items.map(
        (i) => (i['main']['temp_max'] as num).toDouble(),
      );

      final firstItem = items.first;

      return Weather.fromDailyJson(firstItem).copyWith(
        minTemp: minTemps.reduce((a, b) => a < b ? a : b).round().toString(),
        maxTemp: maxTemps.reduce((a, b) => a > b ? a : b).round().toString(),
        dayTemp: (temps.reduce((a, b) => a + b) / temps.length)
            .round()
            .toString(),
      );
    }).toList();
  }
}
