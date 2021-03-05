import 'package:dolarbot_app/api/responses/bcraResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/bcraResponse.dart';

class BcraCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String tag;
  final String symbol;
  final BcraResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;

  const BcraCard({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.tag,
    @required this.symbol,
    @required this.data,
    @required this.gradiantColors,
    this.iconAsset,
    this.iconData,
    this.showPoweredBy = false,
    this.showButtons = true,
  })  : assert(iconData != null || iconAsset != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFavorite(
      showPoweredBy: showPoweredBy,
      header: CardHeader(
        title: title,
        showButtons: showButtons,
      ),
      spaceBetweenHeader: Spacing.medium,
      spaceBetweenItems: Spacing.large,
      direction: Axis.vertical,
      rates: [
        CardValue(
          title: subtitle,
          value: data.value,
          symbol: symbol,
          valueSize: 22,
        ),
      ],
      logo: CardLogo(
        iconData: iconData,
        iconAsset: iconAsset,
        tag: tag,
      ),
      lastUpdated: CardLastUpdated(timestamp: data.timestamp),
      gradiantColors: gradiantColors,
    );
  }
}
