import 'package:easy_localization/easy_localization.dart';

abstract class DateTimeHelper {
  static String formatDateWithMonthName({required String? date}) {
    try {
      if (date == null) return "";
      return DateFormat('dd-MMM-yyyy')
          .format(DateTime.parse(date).toLocal());
    } catch (e) {
      print(e);
      return '';
    }
  }

  static DateTime convertToUtc({required DateTime date}) {
    return date.toUtc();
  }

  static DateTime toLocal({required DateTime date}) {
    return date.toLocal();
  }
}
