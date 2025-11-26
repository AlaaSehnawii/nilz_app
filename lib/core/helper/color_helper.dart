import 'dart:ui';

abstract class ColorHelper {
  static Color fromHex(String hexString) {
    if (hexString.isEmpty || (hexString.startsWith("#") == false)) {
      return const Color(0xFF000000);
    }
    return Color(int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
