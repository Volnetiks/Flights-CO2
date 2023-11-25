import 'package:flights_co2/aircraft.dart';
import 'package:flights_co2/aircraft_search.dart';
import 'package:flights_co2_example/classes/aircraft/aircraft_search_result_tile.dart';
import 'package:flights_co2_example/classes/search_placeholder.dart';
import 'package:flutter/material.dart';

class AircraftSearchDelegate extends SearchDelegate<Aircraft?> {
  AircraftSearchDelegate({required this.aircraftSearch});

  final AircraftSearch aircraftSearch;

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation
      ),
      onPressed: () {
        close(context, null);
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildMatchingSuggestions(context);    
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildMatchingSuggestions(context);
  }

  Widget buildMatchingSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }

    final searched = aircraftSearch.searchString(query);
    
    if (searched.isEmpty) {
      return const SearchPlaceHolder(title: 'No results...');
    }

    return ListView.builder(
      itemCount: searched.length,
      itemBuilder: (context, index) {
        return AircraftSearchResultTile(
          aircraft: searched[index],
          searchDelegate: this
        );
      },
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return query.isEmpty ? [] : [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

}