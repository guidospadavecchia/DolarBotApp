import 'package:dolarbot_app/api/responses/countryRiskResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/countryRiskResponse.dart';

class CountryRiskCard extends StatelessWidget {
  final String title;
  final String tag;
  final IconData iconData;
  final String iconAsset;
  final List<Color> gradiantColors;
  final CountryRiskResponse data;

  const CountryRiskCard({
    Key key,
    @required this.title,
    @required this.data,
    @required this.tag,
    @required this.gradiantColors,
    this.iconAsset,
    this.iconData,
  })  : assert(iconData != null || iconAsset != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardFavorite(
      showPoweredBy: true,
      height: 150,
      header: CardHeader(
        title: title,
        showButtons: false,
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
