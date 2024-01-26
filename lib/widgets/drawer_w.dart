import 'package:flutter/material.dart';
import 'package:weather_tasks_app/screens/weather_screen.dart';

class DrawerW extends StatelessWidget {
  const DrawerW({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          )),
          child: Row(
            children: [
              Text(
                'Menu',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              )
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.directions_run),
          title: const Text('Tasks'),
          onTap: () => Navigator.of(context).pop(),
        ),
        ListTile(
          leading: const Icon(Icons.wb_sunny),
          title: const Text('Weather'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const WeatherScreen()),
            );
          },
        ),
      ]),
    );
  }
}
