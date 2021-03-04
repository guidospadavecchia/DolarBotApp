import 'package:dolarbot_app/api/responses/venezuelaResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/venezuelaResponse.dart';

class VenezuelaCard extends StatelessWidget {
  final String title;
  final String tag;
  final IconData iconData;
  final String iconAsset;
  final List<Color> gradiantColors;
  final VenezuelaResponse data;

  const VenezuelaCard({
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
      height: 210,
      header: CardHeader(
        title: title,
        showButtons: false,
      ),
      rates: [
        CardValue(
          title: "Promedio Bancos",
          value: data.bankPrice,
          symbol: "Bs.",
          spaceMainAxisEnd: Spacing.large,
          titleSize: 16,
          valueSize: 20,
        ),
        CardValue(
          title: "Paralelo",
          value: data.blackMarketPrice,
          symbol: "Bs.",
          spaceMainAxisEnd: Spacing.none,
          titleSize: 16,
          valueSize: 20,
        ),
      ],
      logo: CardLogo(
        iconAsset: iconAsset,
        iconData: iconData,
        tag: tag,
      ),
      lastUpdated: CardLastUpdated(
        timestamp: data.timestamp,
      ),
      gradiantColors: gradiantColors,
    );
  }
}
