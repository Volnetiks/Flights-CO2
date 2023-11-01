import 'package:flights_co2/airport.dart';
import 'package:flights_co2/airport_search.dart';
import 'package:flights_co2/flight_class.dart';
import 'package:flights_co2_example/classes/airport_search_delegate.dart';
import 'package:flights_co2_example/classes/airport_widget.dart';
import 'package:flights_co2_example/classes/flight_details.dart';
import 'package:flights_co2_example/classes/flight_details_block.dart';
import 'package:flights_co2_example/classes/flight_type.dart';
import 'package:flights_co2_example/classes/toggle_button.dart';
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

  List<Widget> flightClasses = [
    const Text("Economy"),
    const Text("Premium")
  ];

  List<Widget> flightTypes = [
    const Text("One Way"),
    const Text("Round trip")
  ];

  List<bool> selectFlightClass = [true, false];

  List<bool> selectedFlightType = [false, true];

  List<String> messages = [
    "Departure Airport",
    "Arrival Airport ",
    "Round Trip"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white.withOpacity(0.4)
            ),
            width: double.infinity,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text('${messages[0]} - ${messages[1]} (${messages[2]})')
              // child: RichText(
              //   text: TextSpan(
              //     style: const TextStyle(
              //       fontSize: 14.0,
              //       color: Colors.black,
              //     ),
              //     children: messages
              //   ),
              // ),
            ),
          )
        ),
        const SizedBox(height: 16,),
        ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white.withOpacity(0.4)
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
                ToggleButton(
                  selectedItems: selectedFlightType,
                  widgets: flightTypes,
                  onChange: (int index) {
                    setState(() {
                      widget.flightDetailsBlock.updateWith(flightType: index == 0 ? FlightType.oneWay : FlightType.twoWays);
                      messages[3] = index == 0 ? "One Way" : "Round Trip";
                    });
                  }
                ),
                const SizedBox(height: 16),
                ToggleButton(
                  selectedItems: selectFlightClass,
                  widgets: flightClasses,
                  onChange: (int index) {
                    setState(() {
                      widget.flightDetailsBlock.updateWith(flightClass: index == 0 ? FlightClass.economy : FlightClass.premium);
                    });
                  },
                ),
                const SizedBox(height: 16)
              ]
            )
          )
        ),
      ],
    );
  }

  void selectDeparture(BuildContext context) async {
    final departure = await showAirportSearch(context);
    widget.flightDetailsBlock.updateWith(departure: departure);
    setState(() {
      messages[0] = '${departure!.city} (${departure.iata})';
    });
  }
  
  void selectArrival(BuildContext context) async {
    final arrival = await showAirportSearch(context);
    widget.flightDetailsBlock.updateWith(arrival: arrival);
    setState(() {
      messages[1] = '${arrival!.city} (${arrival.iata})';
    });
  }

  Future<Airport?> showAirportSearch(BuildContext context) async {
    return await showSearch<Airport?>(
      context: context,
      delegate: AirportSearchDelegate(airportSearch: widget.airportSearch)
    );
  }
}