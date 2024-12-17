class UnitUtils {
  static String formatByteLength(int length) {
    const int kLength = 1000;
    final List<String> units = ["B", "KB", "MB", "GB"];
    for (var i = 0; i < units.length; i++) {
      if (length < kLength) {
        return '$length${units[i]}';
      }
      length ~/= kLength;
    }
    return '${length * kLength}${units[units.length - 1]}';
  }
}
