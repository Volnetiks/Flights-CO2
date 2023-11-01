import 'package:flutter/material.dart';

class AirportSearchPlaceHolder extends StatelessWidget {
  const AirportSearchPlaceHolder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Text(
        title,
        style: theme.textTheme.headlineMedium,
        textAlign: TextAlign.center,
      )
    );
  }
}