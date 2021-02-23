import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/widgets/toasts/toast_error.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static String getFiatCurrencySymbol(ApiResponse data) {
    if (data is DollarResponse) return "US\$";
    if (data is EuroResponse) return "€";
    if (data is RealResponse) return "R\$";
    if (data is VenezuelaResponse) return "Bs.";

    return null;
  }

  static launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Future.delayed(
        Duration(milliseconds: 100),
        () => showToastWidget(
          ToastError(
            padding: EdgeInsets.only(bottom: 100),
          ),
        ),
      );
    }
  }
}
