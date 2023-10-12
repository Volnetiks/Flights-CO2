import 'location_coordinate_2d.dart';

class Airport{
  Airport({
    required this.name,
    required this.city,
    required this.country,
    this.iata,
    this.icao,
    required this.location,
  });
  
  final String name;
  final String city;
  final String country;
  final String? iata;
  final String? icao;
  final LocationCoordinate2D location;

  factory Airport.fromLine(String line) {
    final components = line.split(",");
    if (components.length < 8) {
      return Airport(
        name: "",
        city: "",
        country: "",
        location: LocationCoordinate2D(latitude: 0, longitude: 0),
      );
    }
    String name = unescapeString(components[1]);
    String city = unescapeString(components[2]);
    String country = unescapeString(components[3]);
    String iata = unescapeString(components[4]);
    if (iata == '\\N') { // placeholder for missing iata code
      iata = "";
    }
    String icao = unescapeString(components[5]);
    try {
      double latitude = double.parse(unescapeString(components[6]));
      double longitude = double.parse(unescapeString(components[7]));
      final location = LocationCoordinate2D(
          latitude: latitude, longitude: longitude);
      return Airport(
        name: name,
        city: city,
        country: country,
        iata: iata,
        icao: icao,
        location: location,
      );
    } catch (e) {
      try {
        // sometimes, components[6] is a String and the lat-long are stored
        // at index 7 and 8
        double latitude = double.parse(unescapeString(components[7]));
        double longitude = double.parse(unescapeString(components[8]));
        final location = LocationCoordinate2D(
            latitude: latitude, longitude: longitude);
        return Airport(
          name: name,
          city: city,
          country: country,
          iata: iata,
          location: location,
        );
      } catch (e) {
        print(e);
        return Airport(
          name: "",
          city: "",
          country: "",
          location: LocationCoordinate2D(latitude: 0, longitude: 0),
        );
      }
    }
  }

  // All fields are escaped with double quotes. This method deals with them
  static String unescapeString(dynamic value) {
    if (value is String) {
      return value.replaceAll('"', '');
    }
    return "";
  }

  @override
  String toString() {
    return "($iata, $icao) -> $name, $city, $country, ${location.toString()}";
  }
}