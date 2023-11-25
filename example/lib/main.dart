import 'package:flights_co2/aircraft.dart';
import 'package:flights_co2/aircraft_search.dart';
import 'package:flights_co2/airport.dart';
import 'package:flights_co2/data_reader.dart';
import 'package:flights_co2/airport_search.dart';
import 'package:flights_co2_example/classes/flight_details_block.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/flight_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  List<Airport> airports = await DataReader.loadAirports("data/airports.dat");
  List<Aircraft> aircrafts = await DataReader.loadAircrafts("data/aircrafts.dat");
  runApp(FlightsCO2(airportSearch: AirportSearch(airports: airports), aircraftSearch: AircraftSearch(aircrafts: aircrafts),));
}

class FlightsCO2 extends StatelessWidget {
  const FlightsCO2({super.key, this.airportSearch, this.aircraftSearch});

  final AirportSearch? airportSearch;
  final AircraftSearch? aircraftSearch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight CO2 calculator',
      debugShowCheckedModeBanner: false,
      home: Provider<FlightDetailsBlock>(
        create: (context) => FlightDetailsBlock(),
        dispose: (context, block) => block.dispose(),
        child: FlightPage(airportSearch: airportSearch!, aircraftSearch: aircraftSearch!,)
      ),
    );
  }
}