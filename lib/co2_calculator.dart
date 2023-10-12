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
        a: _interpolate(a: shortHaulParameters.a, b: longHaulParameters.a, value: normalizedDistance),
        b: _interpolate(a: shortHaulParameters.b, b: longHaulParameters.b, value: normalizedDistance),
        c: _interpolate(a: shortHaulParameters.c, b: longHaulParameters.c, value: normalizedDistance),
        seatNumber: _interpolate(a: shortHaulParameters.seatNumber, b: longHaulParameters.seatNumber, value: normalizedDistance),
        passengerLoadFactor: _interpolate(a: shortHaulParameters.passengerLoadFactor, b: longHaulParameters.passengerLoadFactor, value: normalizedDistance),
        detourConstant: _interpolate(a: shortHaulParameters.detourConstant, b: longHaulParameters.detourConstant, value: normalizedDistance),
        invCf:
            _interpolate(a: shortHaulParameters.invCf, b: longHaulParameters.invCf, value: normalizedDistance),
        economyCW: _interpolate(
            a: shortHaulParameters.economyCW, b: longHaulParameters.economyCW, value: normalizedDistance),
        businessCW: _interpolate(
            a: shortHaulParameters.businessCW, b: longHaulParameters.businessCW, value: normalizedDistance),
        firstCW:
            _interpolate(a: shortHaulParameters.firstCW, b: longHaulParameters.firstCW, value: normalizedDistance),
        emissionFactor: _interpolate(a: shortHaulParameters.emissionFactor, b: longHaulParameters.emissionFactor, value: normalizedDistance),
        preProduction: _interpolate(a: shortHaulParameters.preProduction, b: longHaulParameters.preProduction, value: normalizedDistance),
        multiplier: _interpolate(a: shortHaulParameters.multiplier, b: longHaulParameters.multiplier, value: normalizedDistance));
  }

  static double calculateCO2e(double distanceKm, FlightClass flightClass) {
    FlightParameters fp = flightParameters(distanceKm: distanceKm);
    double distanceTotal = distanceKm + fp.detourConstant!;
    double classWeight = _flightClassWeight(
      flightClass: flightClass,
      economy: fp.economyCW!,
      business: fp.businessCW!,
      first: fp.firstCW!,
    );
    return (fp.a! * distanceTotal * distanceTotal + fp.b! * distanceTotal + fp.c!) /
        (fp.seatNumber! * fp.passengerLoadFactor!) * fp.invCf! * classWeight * (fp.emissionFactor! + fp.preProduction!);
  }

  static double correctedDistanceKm(double distanceKm) {
    final fp = flightParameters(distanceKm: distanceKm);
    return distanceKm + fp.detourConstant!;
  }
}