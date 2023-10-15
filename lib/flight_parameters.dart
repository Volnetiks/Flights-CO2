class FlightParameters {
  FlightParameters({
    this.seatNumber,
    this.passengerLoadFactor,
    this.detourConstant,
  });

  final double? seatNumber; // average seat number
  final double? passengerLoadFactor; // passenger load factor
  final double? detourConstant; // detour constant

  static FlightParameters shortHaulParams = FlightParameters(
      seatNumber: 158.44,
      passengerLoadFactor: 0.77,
      detourConstant: 50,);

  static FlightParameters longHaulParams = FlightParameters(
      seatNumber: 280.39,
      passengerLoadFactor: 0.77,
      detourConstant: 125,);
}