import 'package:flights_co2/aircraft.dart';
import 'package:flights_co2/airport.dart';
import 'package:flutter/services.dart';

class DataReader {
  static Future<List<Airport>> loadAirports(String path) async {
    final data = await rootBundle.loadString(path);

    return data.split("\n").map((line) => Airport.fromLine(line)).where((airport) => airport.city != "").toList();
  }

  static Future<List<Aircraft>> loadAircrafts(String path) async {
    final data = await rootBundle.loadString(path);

    return data.split("\n").map((line) => Aircraft.fromLine(line)).toList();
  }
}