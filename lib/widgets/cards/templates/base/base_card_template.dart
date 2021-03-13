import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

export 'package:dolarbot_app/screens/home/home_screen.dart';
export 'package:screenshot/screenshot.dart';

abstract class BaseCardTemplate extends StatefulWidget {
  final String title;
  final String subtitle;
  final String tag;
  final String symbol;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;

  const BaseCardTemplate({
    Key key,
    this.title,
    this.subtitle,
    this.tag,
    this.symbol,
    this.gradiantColors,
    this.iconAsset,
    this.iconData,
    this.showPoweredBy,
    this.showButtons,
    @required this.endpoint,
  }) : assert(iconData != null || iconAsset != null);
}

abstract class BaseCardTemplateState<Card extends BaseCardTemplate>
    extends State<BaseCardTemplate> {
  bool showPoweredBy;
  bool showButtons;
  bool isVisible = true;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    showPoweredBy = widget.showPoweredBy;
    showButtons = widget.showButtons;
  }

  void _prepareCardToShare(bool isSharing) {
    showButtons = !isSharing;
    showPoweredBy = isSharing;
    isVisible = !isSharing;
  }

  void onSharePressed() {
    setState(() => _prepareCardToShare(true));

    Future.delayed(Duration(milliseconds: 700), () async {
      await Util.shareCard(screenshotController);
    }).then((_) => setState(() => _prepareCardToShare(false)));
  }

  Widget card();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          child: LoadingFuture(
            indicatorType: Indicator.ballClipRotatePulse,
            size: 96,
            color: ThemeManager.getDottedBorderColor(context),
          ),
          visible: !isVisible,
        ),
        Opacity(
          opacity: isVisible ? 1 : 0,
          child: Screenshot(
            controller: screenshotController,
            child: Container(
              padding: isVisible ? EdgeInsets.only(top: 10, bottom: 10) : EdgeInsets.all(10),
              child: card(),
            ),
          ),
        ),
      ],
    );
  }
}
