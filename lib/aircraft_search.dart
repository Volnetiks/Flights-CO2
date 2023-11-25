import 'package:flights_co2/aircraft.dart';

class AircraftSearch {
  AircraftSearch({required this.aircrafts});

  final List<Aircraft> aircrafts;

  List<Aircraft> searchString(String string) {
    string = string.toLowerCase();
    final List<Aircraft> matching = aircrafts.where((aircraft) {
      return aircraft.name.toLowerCase().contains(string) || aircraft.firstFlight.toLowerCase().contains(string);
    }).toList();

    return matching.isEmpty ? List.empty() : matching;
  }
}