import 'package:flights_co2/airport.dart';
import 'package:flights_co2/co2_calculator.dart';
import 'package:flights_co2/distance_calculator.dart';
import 'package:flights_co2/flight_class.dart';
import 'package:flights_co2_example/classes/flight_details.dart';
import 'package:flights_co2_example/classes/flight_type.dart';
import 'package:intl/intl.dart';

class FlightData {

  FlightData({this.distanceKm, this.co2e});

  final double? distanceKm;
  final double? co2e;

  String get distanceFormatted {
    return distanceKm != null ? '${distanceKm!.roundToDouble().toInt()} km' : '';
  }

  String get co2eFormmated {
    if(co2e != null) {
      double tonnes = co2e!;
      final formatter = NumberFormat.decimalPattern();
      return '${formatter.format(tonnes)} t';
    }
    return "";
  }

  factory FlightData.fromDetails(FlightDetails flightDetails) {
    if(flightDetails.arrival == null || flightDetails.departure == null) {
      return FlightData(distanceKm: 0, co2e: 0);
    }

    double distanceKm;
    double co2e;
    Airport departure = flightDetails.departure!;
    Airport arrival = flightDetails.arrival!;
    double multiplier = flightDetails.flightType == FlightType.oneWay ? 1.0 : 2.0;
    distanceKm = DistanceCalculator.distanceInKmBetween(departure.location, arrival.location);
    distanceKm = CO2Calculator.correctedDistanceKm(distanceKm);
    co2e = CO2Calculator.calculateCO2e(distanceKm, flightDetails.flightClass == null ? FlightClass.economy : flightDetails.flightClass!) * multiplier;

    return FlightData(distanceKm: distanceKm, co2e: co2e);
  }

}