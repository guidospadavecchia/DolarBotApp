import 'package:dolarbot_app/classes/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/base/factory/factory_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

export 'package:dolarbot_app/screens/home/home_screen.dart';
export 'package:intl/intl.dart';

abstract class BaseCard extends StatefulWidget {
  final String title;
  final String bannerTitle;
  final String? subtitle;
  final String tag;
  final String? symbol;
  final ApiResponse? data;
  final List<Color> gradiantColors;
  final IconData? iconData;
  final String? iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;
  final NumberFormat numberFormat;

  const BaseCard({
    Key? key,
    required this.title,
    required this.bannerTitle,
    this.subtitle,
    required this.tag,
    this.symbol,
    this.data,
    required this.gradiantColors,
    this.iconAsset,
    this.iconData,
    required this.showPoweredBy,
    required this.showButtons,
    required this.endpoint,
    required this.numberFormat,
  }) : assert(iconAsset != null || iconData != null);
}

abstract class BaseCardState<Card extends BaseCard> extends State<BaseCard> {
  void onSharePressed() async {
    CardData cardData = CardData(
      title: widget.title,
      bannerTitle: widget.bannerTitle,
      subtitle: widget.subtitle,
      tag: widget.tag,
      symbol: widget.symbol,
      colors: widget.gradiantColors,
      iconAsset: widget.iconAsset,
      iconData: widget.iconData,
      showPoweredBy: true,
      showButtons: false,
      endpoint: widget.endpoint,
      responseType: widget.data.runtimeType,
    );

    Settings settings = Provider.of<Settings>(context, listen: false);
    await Util.shareCard(
      context,
      BuildCard(widget.data).fromCardData(context, cardData, settings),
    );
  }

  void onTap() async {
    CardData cardData = CardData(
      title: widget.title,
      bannerTitle: widget.bannerTitle,
      subtitle: widget.subtitle,
      tag: widget.tag,
      symbol: widget.symbol,
      colors: widget.gradiantColors,
      iconAsset: widget.iconAsset,
      iconData: widget.iconData,
      showPoweredBy: true,
      showButtons: false,
      endpoint: widget.endpoint,
      responseType: widget.data.runtimeType,
    );

    Util.navigateTo(context, BuildScreen(cardData.responseType).fromCardData(context, cardData));
  }

  Widget card();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: card(),
    );
  }
}
