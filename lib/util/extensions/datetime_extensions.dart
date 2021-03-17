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

  String toRelativeString() {
    Duration duration = DateTime.now().difference(this);
    if (duration.inMinutes < 1) {
      return "Ahora";
    } else if (duration.inMinutes == 1) {
      return "Hace 1 minuto";
    } else if (duration.inMinutes >= 1 && duration.inMinutes <= 15) {
      return "Hace ${duration.inMinutes} minutos";
    } else if (duration.inMinutes > 15 && duration.inMinutes < 30) {
      return "Más de 15 minutos";
    } else if (duration.inMinutes == 30) {
      return "Hace media hora";
    } else if (duration.inMinutes > 30 && duration.inMinutes < 60) {
      return "Más de media hora";
    } else if (duration.inHours == 1) {
      return "Hace 1 hora";
    } else if (duration.inHours >= 1 && duration.inHours <= 6) {
      return "Hace ${duration.inHours} horas";
    } else if (duration.inHours > 6 && duration.inHours <= 24) {
      return "Hoy";
    } else if (duration.inDays == 1) {
      return "Ayer";
    } else {
      return this.toLongDateString();
    }
  }

  bool isSameDayAs(DateTime date) {
    return this.year == date.year && this.month == date.month && this.day == date.day;
  }
}
