class InnovayTypeCasters {
  static Map<String, String> castToMapStringString(dynamic map) {
    Map<String, String> newMap = {};
    if (map is Map) {
      map.forEach((key, value) {
        newMap[key.toString()] = value.toString();
      });
    }

    return newMap;
  }

  static Map<String, int> castToMapStringInt(dynamic map) {
    Map<String, int> newMap = {};
    if (map is Map) {
      map.forEach((key, value) {
        var intValue = int.tryParse('$value');
        intValue ??= 0;
        newMap[key.toString()] = intValue;
      });
    }

    return newMap;
  }

  static Map<String, double> castToMapStringDouble(dynamic map) {
    Map<String, double> newMap = {};
    if (map is Map) {
      map.forEach((key, value) {
        var intValue = double.tryParse('$value');
        intValue ??= 0.0;
        newMap[key.toString()] = intValue;
      });
    }

    return newMap;
  }
}
