import 'package:flights_co2/aircraft.dart';
import 'package:flights_co2/airport.dart';
import 'package:flights_co2/flight_class.dart';
import 'package:flights_co2_example/classes/flight_data.dart';
import 'package:flights_co2_example/classes/flight_details.dart';
import 'package:flights_co2_example/classes/flight_type.dart';

class Flight {

  Flight({required this.details, required this.data});

  final FlightDetails details;
  final FlightData data;

  factory Flight.initialData() {
    return Flight(
      details: FlightDetails(),
      data: FlightData()
    );
  }

  Flight copyWith({Airport? departure, Airport? arrival, FlightClass? flightClass, FlightType? flightType, Aircraft? aircraft}) {
    FlightDetails flightDetails = details.copyWith(departure, arrival, flightClass, flightType, aircraft);
    FlightData flightData = FlightData.fromDetails(flightDetails);

    return Flight(details: flightDetails, data: flightData);
  }

}