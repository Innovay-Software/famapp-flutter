import 'dart:math';

class GpsUtil {
  static const num pi = 3.1415926535897932384626;
  static const num xPi = 3.14159265358979324 * 3000.0 / 180.0;
  static const num a = 6378245.0;
  static const num ee = 0.00669342162296594323;

  static num transformLat(num x, num y) {
    num ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(x.abs());
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    return ret;
  }

  static num transformLon(num x, num y) {
    num ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(x.abs());
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
  }

  static List<num> transform(num lat, num lon) {
    if (outOfCN(lat, lon)) {
      return [lat, lon];
    }
    num dLat = transformLat(lon - 105.0, lat - 35.0);
    num dLon = transformLon(lon - 105.0, lat - 35.0);
    num radLat = lat / 180.0 * pi;
    num magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    num sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
    num mgLat = lat + dLat;
    num mgLon = lon + dLon;
    return [mgLat, mgLon];
  }

  static bool outOfCN(num lat, num lon) {
    if (lon < 72.004 || lon > 137.8347) return true;
    if (lat < 0.8293 || lat > 55.8271) return true;
    return false;
  }

  static List<num> gps84ToGcj02(num lat, num lon) {
    if (outOfCN(lat, lon)) {
      return [lat, lon];
    }
    num dLat = transformLat(lon - 105.0, lat - 35.0);
    num dLon = transformLon(lon - 105.0, lat - 35.0);
    num radLat = lat / 180.0 * pi;
    num magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    num sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
    num mgLat = lat + dLat;
    num mgLon = lon + dLon;
    return [mgLat, mgLon];
  }

  static List<num> gcj02ToGps84(num lat, num lon) {
    List<num> gps = transform(lat, lon);
    num longitude = lon * 2 - gps[1];
    num latitude = lat * 2 - gps[0];
    return [latitude, longitude];
  }

  static List<num> gcj02ToBd09(num lat, num lon) {
    num x = lon, y = lat;
    num z = sqrt(x * x + y * y) + 0.00002 * sin(y * xPi);
    num theta = atan2(y, x) + 0.000003 * cos(x * xPi);
    num tempLon = z * cos(theta) + 0.0065;
    num tempLat = z * sin(theta) + 0.006;
    List<num> gps = [tempLat, tempLon];
    return gps;
  }

  static List<num> bd09ToGcj02(num lat, num lon) {
    num x = lon - 0.0065, y = lat - 0.006;
    num z = sqrt(x * x + y * y) - 0.00002 * sin(y * xPi);
    num theta = atan2(y, x) - 0.000003 * cos(x * xPi);
    num tempLon = z * cos(theta);
    num tempLat = z * sin(theta);
    List<num> gps = [tempLat, tempLon];
    return gps;
  }

  static List<num> gps84ToBd09(num lat, num lon) {
    List<num> gcj02 = gps84ToGcj02(lat, lon);
    List<num> bd09 = gcj02ToBd09(gcj02[0], gcj02[1]);
    return bd09;
  }

  static List<num> bd09ToGps84(num lat, num lon) {
    List<num> gcj02 = bd09ToGcj02(lat, lon);
    List<num> gps84 = gcj02ToGps84(gcj02[0], gcj02[1]);
    //保留小数点后六位
    gps84[0] = retain6(gps84[0]);
    gps84[1] = retain6(gps84[1]);
    return gps84;
  }

  static num retain6(num n) {
    return num.parse(n.toStringAsFixed(6));
  }
}
