import 'package:flights_co2/airport.dart';
import 'package:flights_co2/airport_data_reader.dart';
import 'package:flights_co2/airport_search.dart';
import 'package:flights_co2_example/classes/flight_details_block.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/flight_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  List<Airport> airports = await AirportDataReader.load("data/airports.dat");
  runApp(FlightsCO2(airportSearch: AirportSearch(airports: airports)));
}

class FlightsCO2 extends StatelessWidget {
  const FlightsCO2({super.key, this.airportSearch});

  final AirportSearch? airportSearch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flight CO2 calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider<FlightDetailsBlock>(
        create: (context) => FlightDetailsBlock(),
        dispose: (context, block) => block.dispose(),
        child: FlightPage(airportSearch: airportSearch!)
      ),
    );
  }
}