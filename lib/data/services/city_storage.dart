import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/models/city.dart';

class CityStorage {
  final String _key = "saved_cities";

  Future<void> saveCity(City city) async {
    final prefs = await SharedPreferences.getInstance();
    final cities = await getCities();

    if (cities.any((c) => c.name == city.name && c.country == city.country)) {
      return;
    }

    cities.add(city);
    final encoded = cities.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  Future<List<City>> getCities() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.map((c) => City.fromJson(jsonDecode(c))).toList();
  }

  Future<void> clearCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  Future<void> deleteCity(City city) async {
    final prefs = await SharedPreferences.getInstance();
    final cities = await getCities();

    cities.removeWhere(
      (c) =>
          c.name == city.name &&
          c.country == city.country &&
          c.lat == city.lat &&
          c.lon == city.lon,
    );

    final encoded = cities.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  Future<void> saveCities(List<City> cities) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = cities.map((c) => jsonEncode(c.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }
}
