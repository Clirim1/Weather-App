import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/city.dart';
import '../../logic/weather_cubit.dart';
import '../widgets/weather_display.dart';

class WeatherDetailsPage extends StatefulWidget {
  final City city;

  const WeatherDetailsPage({super.key, required this.city});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  late final WeatherCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<WeatherCubit>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.getWeather(widget.city.lat, widget.city.lon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,

        actions: [
          GestureDetector(
            onTap: () => setState(() {
              _cubit.toggleUnits(widget.city.lat, widget.city.lon);
            }),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                color: _cubit.state.metric ? Colors.blue : Colors.orange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                _cubit.state.metric ? '°C' : '°F',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Text(
                "Error: ${state.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state.weather != null &&
              state.weatherForecast != null &&
              state.weather5DaysList != null) {
            final degreeSymbol = state.metric ? "°C" : "°F";

            return WeatherDisplay(
              weather: state.weather!,
              weatherForecast: state.weatherForecast!,
              weather5DaysList: state.weather5DaysList!,
              degreeSymbol: degreeSymbol,
              city: widget.city,
            );
          }

          return const Center(
            child: Text(
              "No weather data available",
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
