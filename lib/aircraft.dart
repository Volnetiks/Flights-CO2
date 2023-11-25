class Aircraft {

  Aircraft(this.name, this.firstFlight, this.numberOfSeats, this.fuelBurnKm, this.fuelBurnMiles, this.fuelPerSeat, this.fuelPerSeatMPG);

  final String name;
  final String firstFlight; // YEAR
  final int numberOfSeats;
  final double fuelBurnKm;
  final double fuelBurnMiles;
  final double fuelPerSeat; // LITERS PER 100 KM
  final double fuelPerSeatMPG;

  factory Aircraft.fromLine(String line) {
    final components = line.split(", ");
    String name = unescapeString(components[0]);
    String firstFlight = unescapeString(components[1]);
    int seatNumber = int.parse(unescapeString(components[2]));
    double fuelBurnKm = double.parse(unescapeString(components[3]));
    double fuelBurnMiles = double.parse(unescapeString(components[4]));
    double fuelPerSeat = double.parse(unescapeString(components[5]));
    double fuelPerSeatMPG = double.parse(unescapeString(components[6]));

    return Aircraft(name, firstFlight, seatNumber, fuelBurnKm, fuelBurnMiles, fuelPerSeat, fuelPerSeatMPG);
  }

  static String unescapeString(dynamic value) {
    if (value is String) {
      return value.replaceAll('"', '');
    }
    return "";
  }
}