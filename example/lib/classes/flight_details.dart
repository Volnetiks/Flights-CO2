import 'package:flights_co2/airport.dart';
import 'package:flights_co2/flight_class.dart';
import 'package:flights_co2_example/classes/flight_type.dart';

class FlightDetails {

  FlightDetails({
    this.departure,
    this.arrival,
    this.flightClass,
    this.flightType
  });
  
  final Airport? departure;
  final Airport? arrival;
  final FlightClass? flightClass;
  final FlightType? flightType;

  FlightDetails copyWith(Airport? departure, Airport? arrival, FlightClass? flightClass, FlightType? flightType) {
    return FlightDetails(
      departure: departure ?? this.departure,
      arrival: arrival ?? this.arrival, 
      flightClass: flightClass ?? this.flightClass, 
      flightType: flightType ?? this.flightType
    );
  }

}