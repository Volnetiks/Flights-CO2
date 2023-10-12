import 'package:flights_co2/airport.dart';
import 'package:flights_co2/flight_class.dart';
import 'package:flights_co2_example/classes/flight.dart';
import 'package:flights_co2_example/classes/flight_type.dart';
import 'package:rxdart/rxdart.dart';

class FlightDetailsBlock {
  BehaviorSubject<Flight> flightSubject = BehaviorSubject<Flight>.seeded(Flight.initialData());
  Stream<Flight> get flightStream => flightSubject.stream;

  void updateWith({Airport? departure, Airport? arrival, FlightClass? flightClass, FlightType? flightType}) {
    Flight newValue = flightSubject.value.copyWith(departure: departure, arrival: arrival, flightClass: flightClass, flightType: flightType);

    flightSubject.add(newValue);
  }

  dispose() {
    flightSubject.close();
  }
}