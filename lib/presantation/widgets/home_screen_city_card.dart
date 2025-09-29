import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/data/models/city.dart';
import 'package:weather_app/data/models/weather.dart';
import 'package:weather_app/data/weather_api.dart' show WeatherApi;
import 'package:weather_app/logic/weather_cubit.dart';
import 'package:weather_app/presantation/screens/weather_details.dart';

class HomeScreenCityCard extends StatefulWidget {
  final City city;
  final VoidCallback onRefresh;
  const HomeScreenCityCard({
    super.key,
    required this.city,
    required this.onRefresh,
  });

  @override
  State<HomeScreenCityCard> createState() => _HomeScreenCityCardState();
}

class _HomeScreenCityCardState extends State<HomeScreenCityCard> {
  final _api = WeatherApi();
  WeatherCubit? cubit;
  String? degreeSymbol;
  Weather? weather;

  @override
  void initState() {
    cubit = context.read<WeatherCubit>();
    degreeSymbol = cubit!.state.metric ? "°C" : "°F";
    loadWeather();
    super.initState();
  }

  loadWeather() async {
    var fetchedWeather = await _api.fetchWeather(
      widget.city.lat,
      widget.city.lon,
      metric: cubit!.state.metric,
    );
    setState(() {
      weather = fetchedWeather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WeatherDetailsPage(city: widget.city),
          ),
        ).then((value) {
          widget.onRefresh();
        });
      },
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Container(
          height: 100,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            children: [
              Text(
                widget.city.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              weather != null
                  ? Row(
                      children: [
                        Image.network(
                          "https://openweathermap.org/img/wn/${weather?.icon}@2x.png",
                        ),
                        SizedBox(width: 20),
                        Text(
                          "${weather?.temperature}$degreeSymbol",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
