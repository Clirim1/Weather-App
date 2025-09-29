import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/data/services/city_storage.dart';
import 'package:weather_app/data/weather_api.dart';
import 'package:weather_app/logic/city_cubit.dart';
import 'package:weather_app/logic/weather_cubit.dart';
import 'package:weather_app/presantation/screens/home_screen.dart';

void main() async {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => WeatherCubit(WeatherApi())),
        BlocProvider(create: (_) => CityCubit(CityStorage())),
      ],
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        textTheme: GoogleFonts.rubikTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: HomeScreen(),
    );
  }
}
