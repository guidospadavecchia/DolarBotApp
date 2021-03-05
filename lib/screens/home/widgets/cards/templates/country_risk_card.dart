import 'package:dolarbot_app/api/responses/countryRiskResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/countryRiskResponse.dart';

class CountryRiskCard extends StatelessWidget {
  static const double height = 130;

  final String title;
  final String tag;
  final CountryRiskResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;

  const CountryRiskCard({
    Key key,
    @required this.title,
    @required this.tag,
    @required this.data,
    @required this.gradiantColors,
    this.iconData,
    this.iconAsset,
    this.showPoweredBy = false,
    this.showButtons = true,
  })  : assert(iconData != null || iconAsset != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFavorite(
      showPoweredBy: showPoweredBy,
      height: height,
      header: CardHeader(
        title: title,
        showButtons: showButtons,
      ),
      spaceBetweenHeader: Spacing.medium,
      spaceBetweenItems: Spacing.large,
      direction: Axis.vertical,
      rates: [
        CardValue(
          title: "puntos",
          value: data.value,
          symbol: "",
          direction: Axis.horizontal,
          textDirection: TextDirection.rtl,
          spaceBetweenTitle: Spacing.small,
          crossAlignment: WrapCrossAlignment.center,
          valueSize: 32,
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
