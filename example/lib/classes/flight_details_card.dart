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

import '../utils/hex_color.dart';

class FlightDetailsCard extends StatefulWidget {
  const FlightDetailsCard({super.key, required this.flightDetails, required this.flightDetailsBlock, required this.airportSearch});

  final FlightDetails flightDetails;
  final FlightDetailsBlock flightDetailsBlock;
  final AirportSearch airportSearch;

  @override
  State<FlightDetailsCard> createState() => FlightDetailsCardState();
}

class FlightDetailsCardState extends State<FlightDetailsCard> {
  
  final Map<FlightClass, Widget> flightClassChildren = const <FlightClass, Widget>{
    FlightClass.economy: Text('Economy'),
    FlightClass.premium: Text('Premium')
  };

  // final Map<FlightType, Widget> flightTypeChildren = const <FlightType, Widget>{
  //   FlightType.oneWay: Text('One Way'),
  //   FlightType.twoWays: Text('Return'),
  // };

  List<Widget> flightTypes = [
    const Text("One Way"),
    const Text("Round trip")
  ];

  List<bool> selectedFlightType = [false, true];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16,),
            AirportWidget(
              iconData: Icons.flight_takeoff,
              title: const Text("Departing From", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
              onPressed: () => selectDeparture(context),
              airport: widget.flightDetails.departure,
            ),
            const SizedBox(height: 16,),
            AirportWidget(
              iconData: Icons.flight_land,
              title: const Text("Flying to", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
              airport: widget.flightDetails.arrival,
              onPressed: () => selectArrival(context),
            ),
            const SizedBox(height: 16,),
            // SegmentedControl<FlightType>(
            //   header: const Text("Type", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
            //   value: flightDetails.flightType != null ? flightDetails.flightType! : FlightType.twoWays,
            //   children: flightTypeChildren,
            //   onValueChanged: (flightType) => flightDetailsBlock.updateWith(flightType: flightType)
            // ),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                for (int i = 0; i < selectedFlightType.length; i++) {
                  selectedFlightType[i] = i == index;
                }

                setState(() {
                  widget.flightDetailsBlock.updateWith(flightType: index == 0 ? FlightType.oneWay : FlightType.twoWays);
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[200],
                color: Colors.red[400],
                constraints: const BoxConstraints(
                  minHeight: 40.0,
                  minWidth: 80.0,
                ),
              isSelected: selectedFlightType,
              children: flightTypes
            ),
            const SizedBox(height: 16),
            SegmentedControl<FlightClass>(
              header: const Text("Class", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
              value: widget.flightDetails.flightClass != null ? widget.flightDetails.flightClass! : FlightClass.economy,
              children: flightClassChildren,
              onValueChanged: (flightClass) => widget.flightDetailsBlock.updateWith(flightClass: flightClass)
            ),
            const SizedBox(height: 16)
          ]
        )
      )
    );
  }

  void selectDeparture(BuildContext context) async {
    final departure = await showAirportSearch(context);
    widget.flightDetailsBlock.updateWith(departure: departure);
  }
  
  void selectArrival(BuildContext context) async {
    final arrival = await showAirportSearch(context);
    widget.flightDetailsBlock.updateWith(arrival: arrival);
  }

  Future<Airport?> showAirportSearch(BuildContext context) async {
    return await showSearch<Airport?>(
      context: context,
      delegate: AirportSearchDelegate(airportSearch: widget.airportSearch)
    );
  }
}