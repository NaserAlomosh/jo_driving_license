import 'package:intl/intl.dart';

class FormatDate {
  static String getDateFormat(String dateTime) {
    if (dateTime.isNotEmpty) {
      DateTime dt = DateTime.parse(dateTime);
      late String formattedDate = DateFormat('yyyy-MM-dd').format(dt);
      return formattedDate;
    } else {
      return '';
    }
  }

  static String formatDateYYYYMMDDHHMM(DateTime? dateTime) {
    String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm').format(dateTime!);
    return formattedDateTime;
  }
}
//
