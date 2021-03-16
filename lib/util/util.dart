import 'dart:async';

import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/widgets/steps/first_time_dialog.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

export 'dart:typed_data';
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
    final tempDir = await getTemporaryDirectory();
    final String fileName = 'dolarbot_${DateTime.now().microsecondsSinceEpoch}.png';

    await controller.captureAndSave(tempDir.path, fileName: fileName).then((String pathFile) async {
      List<String> files = []..add(pathFile);
      List<String> mimeTypes = []..add('image/png');

      await Share.shareFiles(
        files,
        mimeTypes: mimeTypes,
        subject: 'DolarBot',
        text: 'Descargá la app en: https://www.dolarbot.com.ar',
      );
    });

    tempDir.deleteSync(recursive: true);
  }

  static navigateTo(BuildContext context, BaseInfoScreen screen) async {
    if (Navigator.canPop(context)) Navigator.pop(context, true);
    await Future.delayed(Duration(milliseconds: 250)).then(
      (value) => Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (context, animation1, animation2) => screen),
      ),
    );
  }

  static showFirstTimeDialog(BuildContext context, bool isComingFromOptions) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FirstTimeDialog(isComingFromOptions: isComingFromOptions);
      },
    );
  }

  static Future<void> loadImage(List<ImageProvider> providers) {
    final config = ImageConfiguration(
      bundle: rootBundle,
      devicePixelRatio: 1,
      platform: defaultTargetPlatform,
    );
    final Completer<void> completer = Completer();

    for (ImageProvider provider in providers) {
      final ImageStream stream = provider.resolve(config);

      ImageStreamListener listener;

      listener = ImageStreamListener((ImageInfo image, bool sync) {
        debugPrint("Image ${image.debugLabel} finished loading");

        stream.removeListener(listener);
      }, onError: (dynamic exception, StackTrace stackTrace) {
        stream.removeListener(listener);
        FlutterError.reportError(FlutterErrorDetails(
          context: ErrorDescription('image failed to load'),
          library: 'image resource service',
          exception: exception,
          stack: stackTrace,
          silent: true,
        ));
      });

      stream.addListener(listener);
    }
    completer.complete();
    return completer.future;
  }
}
