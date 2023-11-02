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

  static double calculateCO2e(double distanceKm, FlightClass flightClass) {
    FlightParameters fp = flightParameters(distanceKm: distanceKm);
    double distanceTotal = distanceKm + fp.detourConstant!;
    double classWeight = distanceTotal > 3000 && flightClass == FlightClass.premium ? 2.0 : 1.0;
    double fuelKgPerKm = 3.5; // TO CHANGE WITH REAL VALUES
    double seatNumber = 150; // REAL VALUES
    return 3.16 * distanceTotal * fuelKgPerKm / 1000 * 0.85 / (seatNumber * fp.passengerLoadFactor!) * classWeight * 1000;
  }

  static double correctedDistanceKm(double distanceKm) {
    final fp = flightParameters(distanceKm: distanceKm);
    return distanceKm + fp.detourConstant!;
  }
}