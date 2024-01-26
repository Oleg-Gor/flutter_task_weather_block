import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  final String? description;
  const WeatherItem(this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        description!,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
  }
}
