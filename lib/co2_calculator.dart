import 'flight_class.dart';
import 'flight_parameters.dart';



double _flightClassWeight(
    {required FlightClass flightClass, required double economy, required double business, required double first}) {
  switch (flightClass) {
    case FlightClass.economy:
      return economy;
    case FlightClass.business:
      return business;
    case FlightClass.first:
      return first;
  }
}

class CO2Calculator {
  static double _normalize(
      {required double value, required double lowerBound, required double upperBound}) {
    return (value - lowerBound) / (upperBound - lowerBound);
  }

  static double _interpolate({double? a, double? b, double? value}) {
    return b! * value! + a! * (1 - value);
  }

  static FlightParameters flightParameters({required double distanceKm}) {
    double lowerBound = 1500.0;
    double upperBound = 2500.0;
    if (distanceKm <= lowerBound) {
      return FlightParameters.shortHaulParams;
    }
    if (distanceKm >= upperBound) {
      return FlightParameters.longHaulParams;
    }
    double normalizedDistance = _normalize(
        value: distanceKm, lowerBound: lowerBound, upperBound: upperBound);

    final shortHaulParameters = FlightParameters.shortHaulParams;
    final longHaulParameters = FlightParameters.longHaulParams;

    return FlightParameters(
        seatNumber: _interpolate(a: shortHaulParameters.seatNumber, b: longHaulParameters.seatNumber, value: normalizedDistance),
        passengerLoadFactor: _interpolate(a: shortHaulParameters.passengerLoadFactor, b: longHaulParameters.passengerLoadFactor, value: normalizedDistance),
        detourConstant: _interpolate(a: shortHaulParameters.detourConstant, b: longHaulParameters.detourConstant, value: normalizedDistance));
  }

  static double calculateCO2e(double distanceKm, FlightClass flightClass) {
    FlightParameters fp = flightParameters(distanceKm: distanceKm);
    double distanceTotal = distanceKm + fp.detourConstant!;
    // double classWeight = _flightClassWeight(
    //   flightClass: flightClass,
    //   economy: fp.economyCW!,
    //   business: fp.businessCW!,
    //   first: fp.firstCW!,
    // );
    // REUSE CLASS WEIGHT IF FLIGHT LENGTH > 3000
    double fuelKgPerKm = 3.5; // TO CHANGE WITH REAL VALUES
    double seatNumber = fp.seatNumber!; // REAL VALUES
    return 3.16 * distanceTotal * fuelKgPerKm / 1000 * 0.85 / (seatNumber * fp.passengerLoadFactor!);
    // return (fp.a! * distanceTotal * distanceTotal + fp.b! * distanceTotal + fp.c!) /
    //     (fp.seatNumber! * fp.passengerLoadFactor!) * fp.invCf! * classWeight * (fp.emissionFactor! + fp.preProduction!);
  }

  static double correctedDistanceKm(double distanceKm) {
    final fp = flightParameters(distanceKm: distanceKm);
    return distanceKm + fp.detourConstant!;
  }
}