import 'package:flights_co2/aircraft.dart';

import 'flight_class.dart';
import 'flight_parameters.dart';

class CO2Calculator {

  static FlightParameters flightParameters({required double distanceKm}) {
    double lowerBound = 550.0;
    double upperBound = 5500.0;
    if (distanceKm <= lowerBound) {
      return FlightParameters.shortHaulParams;
    } else if (distanceKm >= upperBound) {
      return FlightParameters.longHaulParams;
    } else {
      return FlightParameters.mediumHaulParams;
    }
  }

  static double calculateCO2e(double distanceKm, FlightClass flightClass, Aircraft aircraft) {
    FlightParameters fp = flightParameters(distanceKm: distanceKm);
    double distanceTotal = distanceKm + fp.detourConstant!;
    double classWeight = distanceTotal > 3000 && flightClass == FlightClass.premium ? 2.0 : 1.0;
    return 3.16 * distanceTotal / 100 * aircraft.fuelPerSeat * classWeight;
  }

  static double correctedDistanceKm(double distanceKm) {
    final fp = flightParameters(distanceKm: distanceKm);
    return distanceKm + fp.detourConstant!;
  }
}