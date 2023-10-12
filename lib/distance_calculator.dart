import 'dart:math';

import 'location_coordinate_2d.dart';

class DistanceCalculator {

  static double distanceInMetersBetween(LocationCoordinate2D lhs, LocationCoordinate2D rhs) {

    double radPerDeg = pi / 180.0;  // PI / 180
    double rkm = 6371.0;// Earth radius in kilometers
    double rm = rkm * 1000.0;// Radius in meters

    double dlatRad = (rhs.latitude - lhs.latitude) * radPerDeg; // Delta, converted to rad
    double dlonRad = (rhs.longitude - lhs.longitude) * radPerDeg;

    double lat1Rad = lhs.latitude * radPerDeg;
    double lat2Rad = rhs.latitude * radPerDeg;

    double sinDlat = sin(dlatRad/2);
    double sinDlon = sin(dlonRad/2);

    double a = sinDlat * sinDlat + cos(lat1Rad) * cos(lat2Rad) * sinDlon * sinDlon;
    double c = 2.0 * atan2(sqrt(a), sqrt(1-a));
    return rm * c;
  }

  static double distanceInKmBetween(LocationCoordinate2D lhs, LocationCoordinate2D rhs) {
    return distanceInMetersBetween(lhs, rhs) / 1000.0;
  }
}