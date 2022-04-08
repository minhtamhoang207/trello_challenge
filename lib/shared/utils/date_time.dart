import 'package:intl/intl.dart';

class AppDateTime {
  static String formatDate(String dateTime) {
    return DateFormat('dd-MM-yyyy').format(DateTime.parse(dateTime)).toString();
  }
}