import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/weather_forcase.dart';
import '../data/weather_api.dart';
import '../data/models/weather.dart';

class WeatherState {
  final Weather? weather;
  final WeatherForecast? weatherForecast;
  final List<Weather>? weather5DaysList;
  final bool loading;
  final bool metric;
  final String? error;

  WeatherState({
    this.weather,
    this.loading = false,
    this.metric = true,
    this.weatherForecast,
    this.weather5DaysList,
    this.error,
  });

  WeatherState copyWith({
    Weather? weather,
    WeatherForecast? weatherForecast,
    List<Weather>? weather5DaysList,
    bool? loading,
    bool? metric,
    String? error,
  }) {
    return WeatherState(
      weather: weather ?? this.weather,
      weatherForecast: weatherForecast ?? this.weatherForecast,
      loading: loading ?? this.loading,
      metric: metric ?? this.metric,
      weather5DaysList: weather5DaysList ?? this.weather5DaysList,
      error: error,
    );
  }
}

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherApi api;
  WeatherCubit(this.api) : super(WeatherState());

  Future<void> getWeather(double lat, double lon) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final weather = await api.fetchWeather(lat, lon, metric: state.metric);
      final weatherForcast = await api.fetchHourlyWeather(
        lat,
        lon,
        metric: state.metric,
      );
      final weather5DaysList = await api.fetch5DayForecastDaily(
        lat,
        lon,
        metric: state.metric,
      );

      emit(
        state.copyWith(
          weather: weather,
          weatherForecast: weatherForcast,
          weather5DaysList: weather5DaysList,
          loading: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> toggleUnits(double lat, double lon) async {
    final newMetric = !state.metric;
    emit(state.copyWith(metric: newMetric, loading: true, error: null));

    try {
      await getWeather(lat, lon);
    } catch (_) {
      emit(state.copyWith(loading: false));
    }
  }

  toogleStateMetric() {
    final newMetric = !state.metric;
    emit(state.copyWith(metric: newMetric, loading: true, error: null));
  }
}
