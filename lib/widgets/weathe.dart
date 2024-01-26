import 'package:flutter/material.dart';

import 'package:weather_tasks_app/widgets/weather_item.dart';

const double kelvinToFarCoefficient = 9 / 5;
const double kelvinToFarOffset = 32;
const double absoluteZeroCelsius = 273.15;
const String noInfo = 'NO INFO';

class Weather extends StatelessWidget {
  final dynamic weather;
  const Weather({super.key, required this.weather});

  String kelvinToFar(double? kelvin) {
    if (kelvin == null) return noInfo;
    return ((kelvin - absoluteZeroCelsius) * kelvinToFarCoefficient +
            kelvinToFarOffset)
        .toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final mainWeather = weather['weather']?[0] ?? {};
    final mainInfo = weather['main'] ?? {};
    final windInfo = weather['wind'] ?? {};
    final weatherTemper = kelvinToFar(mainInfo['temp']);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WeatherItem(
              'Your location: ${weather['name'] ?? noInfo}, ${weather['sys']?['country'] ?? noInfo}'),
          const SizedBox(height: 32),
          WeatherItem('Temperature: $weatherTemper °C'),
          WeatherItem('Description: ${mainWeather['description'] ?? noInfo}'),
          WeatherItem('Wind Speed: ${windInfo['speed'] ?? noInfo} m/s'),
          WeatherItem('Rainfall: ${weather['rain']?['1h'] ?? noInfo} mm/h'),
          WeatherItem('Humidity: ${mainInfo['humidity'] ?? noInfo}%'),
        ],
      ),
    );
  }
}
