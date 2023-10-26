import 'dart:math';
import 'package:vector_math/vector_math.dart';

import 'location_coordinate_2d.dart';

class DistanceCalculator {

  static double distanceInMetersBetweenOld(LocationCoordinate2D lhs, LocationCoordinate2D rhs) {

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

  static double distanceInMetersBetween(LocationCoordinate2D departure, LocationCoordinate2D arrival) {
    double x1 = radians(departure.latitude);
    double y1 = radians(departure.longitude);
    double x2 = radians(arrival.latitude);
    double y2 = radians(arrival.longitude);

    double angle1 = acos(sin(x1) * sin(x2) + cos(x1) * cos(x2) * cos(y1 - y2));
    angle1 = degrees(angle1);

    double distance = angle1 * 60;
    print(distance);

    double distanceMeters = distance * 1.852;
    
    return distanceMeters;
  }

  static double distanceInKmBetween(LocationCoordinate2D lhs, LocationCoordinate2D rhs) {
    return distanceInMetersBetween(lhs, rhs);
  }
}