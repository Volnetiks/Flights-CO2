import 'package:flights_co2/aircraft.dart';
import 'package:flights_co2/aircraft_search.dart';
import 'package:flights_co2/airport.dart';
import 'package:flights_co2/airport_search.dart';
import 'package:flights_co2/flight_class.dart';
import 'package:flights_co2_example/classes/aircraft/aircraft_search_delegate.dart';
import 'package:flights_co2_example/classes/aircraft/aircraft_widget.dart';
import 'package:flights_co2_example/classes/airport/airport_search_delegate.dart';
import 'package:flights_co2_example/classes/airport/airport_widget.dart';
import 'package:flights_co2_example/classes/animated_toggle.dart';
import 'package:flights_co2_example/classes/flight_data.dart';
import 'package:flights_co2_example/classes/flight_details.dart';
import 'package:flights_co2_example/classes/flight_details_block.dart';
import 'package:flights_co2_example/classes/flight_type.dart';
import 'package:flights_co2_example/utils/hex_color.dart';
import 'package:flutter/material.dart';

class FlightDetailsCardExpandable extends StatefulWidget {
  const FlightDetailsCardExpandable({super.key, required this.flightDetails, required this.flightDetailsBlock, required this.airportSearch, required this.flightData, required this.aircraftSearch});

  final FlightDetails flightDetails;
  final FlightDetailsBlock flightDetailsBlock;
  final AirportSearch airportSearch;
  final AircraftSearch aircraftSearch;
  final FlightData flightData;

  @override
  State<FlightDetailsCardExpandable> createState() => _FlightDetailsCardExpandableState();
}

class _FlightDetailsCardExpandableState extends State<FlightDetailsCardExpandable> {

  List<String> messages = [
    "Departure Airport",
    "Arrival Airport ",
    "Round Trip"
  ];

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.white.withOpacity(0.3)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text('${messages[0]} - ${messages[1]} (${messages[2]})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center,),
        )
      ),
      tilePadding: const EdgeInsets.all(0),
      textColor: Colors.black,
      iconColor: Colors.grey[700],
      collapsedIconColor: Colors.grey[700],
      shape: const Border(),
      children: [
        Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: Colors.white.withOpacity(0.3)
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
                AircraftWidget(
                  iconData: Icons.airplanemode_on,
                  title: const Text("Aircraft Model", style: TextStyle(fontSize: 13.0, color: Colors.black54)),
                  aircraft: widget.flightDetails.aircraft,
                  onPressed: () => selectAircraft(context),
                ),
                const SizedBox(height: 16,),
                AnimatedToggle(
                  values: const ["One Way", "Round Trip"],
                  index: 1,
                  buttonColor: HexColor.fromHex("#f2e98e"),
                  onToggleCallback: (index) {
                    setState(() {
                      widget.flightDetailsBlock.updateWith(flightType: index == 0 ? FlightType.oneWay : FlightType.twoWays);
                      messages[2] = index == 0 ? "One Way" : "Round Trip";
                    });
                  }
                ),
                const SizedBox(height: 16),
                AnimatedToggle(
                  values: const ["Economy", "Premium"],
                  buttonColor: HexColor.fromHex("#f2e98e"),
                  onToggleCallback: (index) {
                    setState(() {
                      widget.flightDetailsBlock.updateWith(flightClass: index == 0 ? FlightClass.economy : FlightClass.premium);
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.black, width: 1.5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${widget.flightData.co2eFormatted} CO2'),
                      )
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(color: Colors.black, width: 1.5)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.flightData.distanceFormatted),
                      )
                    )
                  ],
                ),
                const SizedBox(height: 16,)
              ]
            )
          ),
      ]
    );
  }

  void selectDeparture(BuildContext context) async {
    final departure = await showAirportSearch(context);
    if (departure != null) {
      widget.flightDetailsBlock.updateWith(departure: departure);
      setState(() {
        messages[0] = '${departure.city} (${departure.iata})';
      });
    }
  }
  
  void selectArrival(BuildContext context) async {
    final arrival = await showAirportSearch(context);
    if (arrival != null) {
      widget.flightDetailsBlock.updateWith(arrival: arrival);
      setState(() {
        messages[1] = '${arrival.city} (${arrival.iata})';
      });
    }
  }

  void selectAircraft(BuildContext context) async {
    final aircraft = await showAircraftSearch(context);
    if(aircraft != null) {
      widget.flightDetailsBlock.updateWith(aircraft: aircraft);
      setState(() {});
    }
  }

  Future<Airport?> showAirportSearch(BuildContext context) async {
    return await showSearch<Airport?>(
      context: context,
      delegate: AirportSearchDelegate(airportSearch: widget.airportSearch)
    );
  }

  Future<Aircraft?> showAircraftSearch(BuildContext context) async {
    return await showSearch<Aircraft?>(
      context: context,
      delegate: AircraftSearchDelegate(aircraftSearch: widget.aircraftSearch)
    );
  }
}