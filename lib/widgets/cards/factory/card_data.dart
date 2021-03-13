import 'package:flutter/material.dart';

class CardData {
  final String title;
  final String subtitle;
  final String symbol;
  final String tag;
  final List<Color> colors;
  final IconData iconData;
  final String iconAsset;
  final String endpoint;
  final Type response;
  final bool showButtons;
  final bool showPoweredBy;

  CardData({
    Key key,
    @required this.title,
    this.subtitle,
    this.symbol,
    @required this.tag,
    @required this.colors,
    this.iconData,
    this.iconAsset,
    @required this.endpoint,
    @required this.response,
    this.showButtons = false,
    this.showPoweredBy = true,
  });

  CardData clone({
    String title,
    String subtitle,
    String symbol,
    String tag,
    List<Color> colors,
    IconData iconData,
    String iconAsset,
    String endpoint,
    Type response,
    bool showButtons,
    bool showPoweredBy,
  }) {
    return CardData(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      symbol: symbol ?? this.symbol,
      tag: tag ?? this.tag,
      colors: colors ?? this.colors,
      iconData: iconData ?? this.iconData,
      iconAsset: iconAsset ?? this.iconAsset,
      endpoint: endpoint ?? this.endpoint,
      response: response ?? this.response,
      showButtons: showButtons ?? this.showButtons,
      showPoweredBy: response ?? this.showPoweredBy,
    );
  }
}
