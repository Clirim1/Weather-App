import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/logic/weather_cubit.dart';
import 'package:weather_app/presantation/screens/weather_details.dart';
import 'package:weather_app/presantation/widgets/home_screen_city_card.dart';
import '../../data/models/city.dart';
import '../../data/weather_api.dart';
import '../../logic/city_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _api = WeatherApi();

  late final WeatherCubit _cubit;

  List<City> _suggestions = [];
  bool _loading = false;

  void _onChanged(String query) async {
    if (query.length < 2) {
      setState(() => _suggestions = []);
      return;
    }
    setState(() => _loading = true);
    final results = await _api.searchCities(query);
    setState(() {
      _suggestions = results;
      _loading = false;
    });
  }

  void _onSelect(City city) async {
    context.read<CityCubit>().addCity(city);

    FocusScope.of(context).unfocus();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => WeatherDetailsPage(city: city)),
    );
  }

  void refreshCities() {
    setState(() {
      context.read<CityCubit>().refreshCities();
    });
  }

  @override
  void initState() {
    _cubit = context.read<WeatherCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            _suggestions.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(top: 40),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: _suggestions.length,
                      itemBuilder: (context, index) {
                        final city = _suggestions[index];
                        return ListTile(
                          title: Text("${city.name}, ${city.country}"),
                          onTap: () => _onSelect(city),
                        );
                      },
                    ),
                  )
                : BlocBuilder<CityCubit, List<City>>(
                    builder: (context, savedCities) {
                      if (savedCities.isEmpty) {
                        return const Center(child: Text("No cities saved"));
                      }
                      return Container(
                        padding: const EdgeInsets.only(top: 60),
                        child: ListView.builder(
                          itemCount: savedCities.length,
                          itemBuilder: (context, index) {
                            final city = savedCities[index];
                            return Dismissible(
                              key: ValueKey(city.lat),
                              direction: DismissDirection.endToStart,
                              background: Container(
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.red,
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                              onDismissed: (direction) {
                                context.read<CityCubit>().deleteCity(city);
                                refreshCities();
                              },
                              child: HomeScreenCityCard(
                                city: city,
                                onRefresh: refreshCities,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
            getSearchWidget(),
          ],
        ),
      ),
    );
  }

  Widget getSearchWidget() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: CupertinoSearchTextField(
                controller: _searchController,
                onChanged: _onChanged,
                placeholder: "Enter city...",
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            if (_loading)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            GestureDetector(
              onTap: () {
                _cubit.toogleStateMetric();
                refreshCities();
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: EdgeInsets.only(right: 10, left: 10),
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
      ),
    );
  }
}
