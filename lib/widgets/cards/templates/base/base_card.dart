import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';

export 'package:dolarbot_app/screens/home/home_screen.dart';
export 'package:intl/intl.dart';
export 'package:tuple/tuple.dart';

abstract class BaseCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String tag;
  final String symbol;
  final ApiResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showShareButton;
  final String endpoint;
  final Tuple2<NumberFormat, String> numberFormat;

  const BaseCard({
    Key key,
    this.title,
    this.subtitle,
    this.tag,
    this.symbol,
    this.data,
    this.gradiantColors,
    this.iconAsset,
    this.iconData,
    this.showPoweredBy,
    this.showShareButton,
    @required this.endpoint,
    @required this.numberFormat,
  });
}

abstract class BaseCardState<Card extends BaseCard> extends State<BaseCard> {
  bool showPoweredBy;
  bool showButtons;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    showPoweredBy = widget.showPoweredBy;
    showButtons = widget.showShareButton;
  }

  void onSharePressed() async {
    CardData cardData = CardData(
      title: widget.title,
      subtitle: widget.subtitle,
      tag: widget.tag,
      symbol: widget.symbol,
      colors: widget.gradiantColors,
      iconAsset: widget.iconAsset,
      iconData: widget.iconData,
      showPoweredBy: true,
      showButtons: false,
      endpoint: widget.endpoint,
      response: null,
    );

    Settings settings = Provider.of<Settings>(context, listen: false);
    await Util.shareCard(
      context,
      BuildCard(widget.data).fromCardData(context, cardData, settings),
    );
  }

  Widget card();

  @override
  Widget build(BuildContext context) {
    if (widget.endpoint == null) {
      return SizedBox.shrink();
    }

    return card();
  }
}
