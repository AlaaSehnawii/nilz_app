import 'dart:math';



abstract class RandomHelper {
  static String generateRandomHexString({required int length}) {
    final random = Random();
    final buffer = StringBuffer();

    for (var i = 0; i < length; i++) {
      buffer.write(random.nextInt(16).toRadixString(16));
    }

    return buffer.toString();
  }

  static int randomRang({required int start, required int end}) {
    final random = Random();
    int randomNumber = start + random.nextInt(end - start);
    return randomNumber;
  }
}
