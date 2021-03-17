import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/widgets/steps/first_time_dialog.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_error.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:page_transition/page_transition.dart';
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

  static shareCard(BuildContext context, Widget widget) async {
    final Directory tempDir = await getTemporaryDirectory();

    createImageFromWidget(
            Container(
              width: MediaQuery.of(context).size.width,
              child: MediaQuery(
                data: MediaQueryData(),
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: widget,
                ),
              ),
            ),
            wait: Duration(milliseconds: 100))
        .then(
      (Uint8List image) async {
        final String fileName = 'dolarbot_${DateTime.now().microsecondsSinceEpoch}.png';

        final File file = await File('${tempDir.path}/${fileName}').create();
        await file.writeAsBytesSync(image);

        List<String> files = []..add(file.path);
        List<String> mimeTypes = []..add('image/png');
        await Share.shareFiles(
          files,
          mimeTypes: mimeTypes,
          subject: 'DolarBot',
          text: 'Descargá la app en: https://www.dolarbot.com.ar',
        );
      },
    ).whenComplete(() => tempDir.deleteSync(recursive: true));
  }

  static navigateTo(BuildContext context, BaseInfoScreen screen) async {
    if (Navigator.canPop(context)) Navigator.pop(context, true);
    await Future.delayed(Duration(milliseconds: 250)).then(
      (value) => Navigator.pushReplacement(
        context,
        PageTransition(
          child: screen,
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 150),
          reverseDuration: Duration(milliseconds: 150),
        ),
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

  /// Creates an image from the given widget by first spinning up a element and render tree,
  /// then waiting for the given [wait] amount of time and then creating an image via a [RepaintBoundary].
  ///
  /// The final image will be of size [imageSize] and the the widget will be layout, ... with the given [logicalSize].
  static Future<Uint8List> createImageFromWidget(Widget widget,
      {Duration wait, Size logicalSize, Size imageSize}) async {
    final RenderRepaintBoundary repaintBoundary = RenderRepaintBoundary();

    logicalSize ??= ui.window.physicalSize / ui.window.devicePixelRatio;
    imageSize ??= ui.window.physicalSize;

    assert(logicalSize.aspectRatio == imageSize.aspectRatio);

    final RenderView renderView = RenderView(
      window: null,
      child: RenderPositionedBox(
        alignment: Alignment.center,
        child: repaintBoundary,
      ),
      configuration: ViewConfiguration(
        size: logicalSize,
        devicePixelRatio: 1.0,
      ),
    );

    final PipelineOwner pipelineOwner = PipelineOwner();
    final BuildOwner buildOwner = BuildOwner();

    pipelineOwner.rootNode = renderView;
    renderView.prepareInitialFrame();

    final RenderObjectToWidgetElement<RenderBox> rootElement =
        RenderObjectToWidgetAdapter<RenderBox>(
      container: repaintBoundary,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: widget,
      ),
    ).attachToRenderTree(buildOwner);

    buildOwner.buildScope(rootElement);

    if (wait != null) {
      await Future.delayed(wait);
    }

    buildOwner.buildScope(rootElement);
    buildOwner.finalizeTree();

    pipelineOwner.flushLayout();
    pipelineOwner.flushCompositingBits();
    pipelineOwner.flushPaint();

    final ui.Image image = await repaintBoundary.toImage(pixelRatio: 3);
    final ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData.buffer.asUint8List();
  }
}
