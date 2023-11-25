import 'package:flights_co2/aircraft_search.dart';
import 'package:flights_co2/airport_search.dart';
import 'package:flights_co2_example/classes/flight.dart';
import 'package:flights_co2_example/classes/flight_details_block.dart';
import 'package:flights_co2_example/classes/flight_details_card_expandable.dart';
import 'package:flights_co2_example/utils/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightPage extends StatelessWidget {
  const FlightPage({super.key, required this.airportSearch, required this.aircraftSearch});

  final AirportSearch airportSearch;
  final AircraftSearch aircraftSearch;

  @override
  Widget build(BuildContext context) {
    final flightDetailsBlock = Provider.of<FlightDetailsBlock>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: StreamBuilder<Flight>(
        stream: flightDetailsBlock.flightStream,
        initialData: Flight.initialData(),
        builder: (context, snapshot) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  HexColor.fromHex("#efeea0"),
                  HexColor.fromHex("#06f2a8")
                ]
              )
            ),
            padding: const EdgeInsets.all(20.0),
            child: SafeArea(
              child: Column(
                children: [
                  FlightDetailsCardExpandable(
                      flightDetails: snapshot.data!.details,
                      flightDetailsBlock: flightDetailsBlock,
                      airportSearch: airportSearch,
                      flightData: snapshot.data!.data,
                      aircraftSearch: aircraftSearch,
                  )
                ],
              )
            )
          );
        }
      )
    );
  }
}