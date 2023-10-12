import 'package:flights_co2/airport.dart';
import 'package:flights_co2/airport_search.dart';
import 'package:flights_co2/flight_class.dart';
import 'package:flights_co2_example/classes/airport_search_delegate.dart';
import 'package:flights_co2_example/classes/airport_widget.dart';
import 'package:flights_co2_example/classes/flight_details.dart';
import 'package:flights_co2_example/classes/flight_details_block.dart';
import 'package:flights_co2_example/classes/flight_type.dart';
import 'package:flights_co2_example/classes/segmented_control.dart';
import 'package:flutter/material.dart';

class FlightDetailsCard extends StatelessWidget {
  const FlightDetailsCard({super.key, required this.flightDetails, required this.flightDetailsBlock, required this.airportSearch});

  final FlightDetails flightDetails;
  final FlightDetailsBlock flightDetailsBlock;
  final AirportSearch airportSearch;

  final Map<FlightClass, Widget> flightClassChildren = const <FlightClass, Widget>{
    FlightClass.economy: Text('Economy'),
    FlightClass.business: Text('Business'),
    FlightClass.first: Text('First'),
  };

  final Map<FlightType, Widget> flightTypeChildren = const <FlightType, Widget>{
    FlightType.oneWay: Text('One Way'),
    FlightType.twoWays: Text('Return'),
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
              colors: [
              Color(0xFF068FFA),Color(0xFF89ED91)
            ]
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16,),
            AirportWidget(
              iconData: Icons.flight_takeoff,
              title: const Text("Departing From", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
              onPressed: () => selectDeparture(context),
              airport: flightDetails.departure,
            ),
            const SizedBox(height: 16,),
            AirportWidget(
              iconData: Icons.flight_land,
              title: const Text("Flying to", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
              airport: flightDetails.arrival,
              onPressed: () => selectArrival(context),
            ),
            const SizedBox(height: 16,),
            SegmentedControl<FlightType>(
              header: const Text("Type", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
              value: flightDetails.flightType != null ? flightDetails.flightType! : FlightType.twoWays,
              children: flightTypeChildren,
              onValueChanged: (flightType) => flightDetailsBlock.updateWith(flightType: flightType)
            ),
            const SizedBox(height: 16),
            SegmentedControl<FlightClass>(
              header: const Text("Class", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
              value: flightDetails.flightClass != null ? flightDetails.flightClass! : FlightClass.first,
              children: flightClassChildren,
              onValueChanged: (flightClass) => flightDetailsBlock.updateWith(flightClass: flightClass)
            ),
            const SizedBox(height: 16)
          ]
        )
      )
    );
  }

  void selectDeparture(BuildContext context) async {
    final departure = await showAirportSearch(context);
    flightDetailsBlock.updateWith(departure: departure);
  }
  
  void selectArrival(BuildContext context) async {
    final arrival = await showAirportSearch(context);
    flightDetailsBlock.updateWith(arrival: arrival);
  }

  Future<Airport?> showAirportSearch(BuildContext context) async {
    return await showSearch<Airport?>(
      context: context,
      delegate: AirportSearchDelegate(airportSearch: airportSearch)
    );
  }
}