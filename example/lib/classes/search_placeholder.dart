import 'package:flutter/material.dart';

class SearchPlaceHolder extends StatelessWidget {
  const SearchPlaceHolder({super.key, required this.title});

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