class LocationCoordinate2D {
  LocationCoordinate2D({required this.latitude, required this.longitude});
  final double latitude;
  final double longitude;

  @override
  String toString() {
    return "($latitude, $longitude)";
  }
}