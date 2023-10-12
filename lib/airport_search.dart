import 'airport.dart';

class AirportSearch {
  AirportSearch({required this.airports});

  final List<Airport> airports;

  Airport searchIata(String iata) {
    return airports.firstWhere((airport) => airport.iata == iata);
  }

  List<Airport> searchString(String string) {
    string = string.toLowerCase();
    final List<Airport> matching = airports.where((airport) {
      String iata = airport.iata ?? '';
      return iata.toLowerCase() == string || airport.name.toLowerCase() == string || airport.city.toLowerCase() == string || airport.country.toLowerCase() == string;
    }).toList();

    if(matching.isNotEmpty) {
      return matching;
    }

    return airports.where((airport) {
      final String iata = airport.iata ?? '';
      return iata.toLowerCase().contains(string) || airport.name.toLowerCase().contains(string) || airport.city.toLowerCase().contains(string) || airport.country.toLowerCase().contains(string);
    }).toList();
  }
}