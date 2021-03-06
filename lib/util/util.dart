import 'dart:typed_data';

import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/toasts/toast_error.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

export 'dart:typed_data';
export 'package:esys_flutter_share/esys_flutter_share.dart';
export 'package:oktoast/oktoast.dart';

class Util {
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
          ToastError(),
        ),
      );
    }
  }

  static shareCard(ScreenshotController controller) async {
    await controller.capture().then((Uint8List image) async {
      Share.file(
          'DolarBot',
          'dolarbot_${DateTime.now().microsecondsSinceEpoch}.png',
          image,
          'image/png',
          text: 'Descargá la app en: https://www.dolarbot.com.ar');
    }).catchError((onError) {
      ToastError();
    });
  }

  static navigateTo(BuildContext context, BaseInfoScreen screen) async {
    if (Navigator.canPop(context)) Navigator.pop(context, true);
    await Future.delayed(Duration(milliseconds: 250)).then(
      (value) => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => screen),
      ),
    );
  }
}
