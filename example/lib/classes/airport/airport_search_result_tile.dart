import 'package:flights_co2/airport.dart';
import 'package:flutter/material.dart';

class AirportSearchResultTile extends StatelessWidget {
  const AirportSearchResultTile({super.key, required this.airport, required this.searchDelegate});

  final Airport airport;
  final SearchDelegate<Airport?> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final title = '${airport.name} (${airport.iata})';
    final subtitle = '${airport.city}, ${airport.country}';
    final ThemeData theme = Theme.of(context);

    return ListTile(
      dense: true,
      title: Text(
        title,
        style: theme.textTheme.bodyMedium,
        textAlign: TextAlign.start
      ),
      subtitle: Text(
        subtitle,
        style: theme.textTheme.bodySmall,
        textAlign: TextAlign.start,
      ),
      onTap: () => searchDelegate.close(context, airport),
    );
  }
}