class FlightParameters {
  FlightParameters({
    this.passengerLoadFactor,
    this.detourConstant,
  });

  final double? passengerLoadFactor; // passenger load factor
  final double? detourConstant; // detour constant

  static FlightParameters shortHaulParams = FlightParameters(
      passengerLoadFactor: 0.77,
      detourConstant: 50,);

  static FlightParameters longHaulParams = FlightParameters(
      passengerLoadFactor: 0.77,
      detourConstant: 100,);

  static FlightParameters mediumHaulParams = FlightParameters(
      passengerLoadFactor: 0.77,
      detourConstant: 125
  );
}