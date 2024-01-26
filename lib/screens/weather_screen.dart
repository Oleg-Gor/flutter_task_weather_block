import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:weather_tasks_app/widgets/weathe.dart';

const API_KEY = "2f12aec34b391e6d378843fa9e63f7d6";

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<dynamic> _weatherFuture;

  @override
  void initState() {
    _weatherFuture = getWeatherData();
    super.initState();
  }

  getWeatherData() async {
    LocationData locationData;
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = Location();

    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      locationData = await location.getLocation();

      final lat = locationData.latitude;
      final lng = locationData.longitude;

      if (lat == null || lng == null) {
        return;
      }
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=$API_KEY');
      final response = await http.get(url);

      return json.decode(response.body);
    } catch (e) {
      inspect(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Weather')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: _weatherFuture,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Weather(
                      weather: snapshot.data ?? {},
                    );
            },
          ),
        ));
  }
}
