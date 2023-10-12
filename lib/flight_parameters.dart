class FlightParameters {
  FlightParameters({
    this.a,
    this.b,
    this.c,
    this.seatNumber,
    this.passengerLoadFactor,
    this.detourConstant,
    this.invCf,
    this.economyCW,
    this.businessCW,
    this.firstCW,
    this.emissionFactor,
    this.preProduction,
    this.multiplier,
  });

  final double? a; // polynomial coefficient
  final double? b; // polynomial coefficient
  final double? c; // polynomial coefficient
  final double? seatNumber; // average seat number
  final double? passengerLoadFactor; // passenger load factor
  final double? detourConstant; // detour constant
  final double? invCf; // 1 - cargo factor
  final double? economyCW; // economy class weight
  final double? businessCW; // business class weight
  final double? firstCW; // first class weight
  final double? emissionFactor; // emission factor
  final double? preProduction; // Pre production
  final double? multiplier; // multiplier

  static FlightParameters shortHaulParams = FlightParameters(
      a: 3.87871E-05,
      b: 2.9866,
      c: 1263.42,
      seatNumber: 158.44,
      passengerLoadFactor: 0.77,
      detourConstant: 50,
      invCf: 0.951,
      economyCW: 0.960,
      businessCW: 1.26,
      firstCW: 2.40,
      emissionFactor: 3.150,
      preProduction: 0.51,
      multiplier: 2);

  static FlightParameters longHaulParams = FlightParameters(
      a: 0.000134576,
      b: 6.1798,
      c: 3446.20,
      seatNumber: 280.39,
      passengerLoadFactor: 0.77,
      detourConstant: 125,
      invCf: 0.951,
      economyCW: 0.800,
      businessCW: 1.54,
      firstCW: 2.40,
      emissionFactor: 3.150,
      preProduction: 0.51,
      multiplier: 2);
}