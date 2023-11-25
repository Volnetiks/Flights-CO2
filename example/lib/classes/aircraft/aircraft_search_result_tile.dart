import 'package:flights_co2/aircraft.dart';
import 'package:flutter/material.dart';

class AircraftSearchResultTile extends StatelessWidget {
  const AircraftSearchResultTile({super.key, required this.aircraft, required this.searchDelegate});

  final Aircraft aircraft;
  final SearchDelegate<Aircraft?> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return ListTile(
      dense: true,
      title: Text(
        aircraft.name,
        style: theme.textTheme.bodyMedium,
        textAlign: TextAlign.start
      ),
      subtitle: Text(
        aircraft.firstFlight,
        style: theme.textTheme.bodySmall,
        textAlign: TextAlign.start,
      ),
      onTap: () => searchDelegate.close(context, aircraft),
    );
  }
}