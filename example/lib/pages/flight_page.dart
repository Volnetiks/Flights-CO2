import 'package:auto_size_text/auto_size_text.dart';
import 'package:flights_co2/airport_search.dart';
import 'package:flights_co2_example/classes/flight.dart';
import 'package:flights_co2_example/classes/flight_calculation_card.dart';
import 'package:flights_co2_example/classes/flight_details_block.dart';
import 'package:flights_co2_example/classes/flight_details_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlightPage extends StatelessWidget {
  const FlightPage({super.key, required this.airportSearch});

  final AirportSearch airportSearch;

  @override
  Widget build(BuildContext context) {
    final flightDetailsBlock = Provider.of<FlightDetailsBlock>(context);

    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<Flight>(
        stream: flightDetailsBlock.flightStream,
        initialData: Flight.initialData(),
        builder: (context, snapshot) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF068FFA),
                  Color(0xFF89ED91)
                ]
              )
            ),
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Column(
                children: [
                  FlightDetailsCard(
                    flightDetails: snapshot.data!.details,
                    flightDetailsBlock: flightDetailsBlock,
                    airportSearch: airportSearch
                  ),
                  FlightCalculationCard(flightData: snapshot.data!.data),
                  Expanded(child: Container()),
                  const AutoSizeText(
                    'Flight CO2 calculation formula',
                    minFontSize: 11.0,
                    maxLines: 1,
                    style: TextStyle(fontSize: 13.0, color: Colors.black54),
                  ),
                  const AutoSizeText(
                    'Airport Data Set by openflights.org',
                    minFontSize: 11.0,
                    maxLines: 1,
                    style: TextStyle(fontSize: 13.0, color: Colors.black54),
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