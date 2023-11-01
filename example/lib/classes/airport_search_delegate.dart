import 'package:flights_co2/airport.dart';
import 'package:flights_co2/airport_search.dart';
import 'package:flights_co2_example/classes/airport_search_placeholder.dart';
import 'package:flights_co2_example/classes/airport_search_result_tile.dart';
import 'package:flutter/material.dart';

class AirportSearchDelegate extends SearchDelegate<Airport?> {
  AirportSearchDelegate({required this.airportSearch});

  final AirportSearch airportSearch;

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

    final searched = airportSearch.searchString(query);
    
    if (searched.isEmpty) {
      return AirportSearchPlaceHolder(title: 'No results...');
    }

    return ListView.builder(
      itemCount: searched.length,
      itemBuilder: (context, index) {
        return AirportSearchResultTile(
          airport: searched[index],
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