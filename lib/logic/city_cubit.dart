import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/services/city_storage.dart';

class CityCubit extends Cubit<List<City>> {
  final CityStorage storage;

  CityCubit(this.storage) : super([]) {
    loadCities();
  }

  Future<void> loadCities() async {
    final cities = await storage.getCities();
    emit(cities);
  }

  Future<void> addCity(City city) async {
    await storage.saveCity(city);
    await loadCities();
  }

  Future<void> deleteCity(City city) async {
    await storage.deleteCity(city);
    await loadCities();
  }

  Future<void> clearCities() async {
    await storage.clearCities();
    emit([]);
  }

  Future<void> refreshCities() async {
    emit([]);
    await Future.delayed(const Duration(milliseconds: 200));
    final cities = await storage.getCities();
    emit(cities);
  }
}
