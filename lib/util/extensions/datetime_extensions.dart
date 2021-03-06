import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toLongDateString() {
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(this);
  }

  String toShortDateString() {
    return DateFormat('dd-MM-yyyy').format(this);
  }

  String toShortDateIsoString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toShortTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  bool isSameDayAs(DateTime date) {
    return this.year == date.year &&
        this.month == date.month &&
        this.day == date.day;
  }
}
