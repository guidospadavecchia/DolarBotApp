import 'package:dolarbot_app/api/responses/cryptoResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/cryptoResponse.dart';

class CryptoCard extends StatelessWidget {
  final String title;
  final String tag;
  final IconData iconData;
  final String iconAsset;
  final List<Color> gradiantColors;
  final CryptoResponse data;

  const CryptoCard({
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
      height: 290,
      header: CardHeader(
        title: title,
        showButtons: false,
      ),
      spaceBetweenItems: Spacing.large,
      direction: Axis.vertical,
      rates: [
        CardValue(
          title: "Pesos Argentinos",
          value: data.arsPrice,
          symbol: "\$",
          valueSize: 22,
        ),
        CardValue(
          title: "Pesos Argentinos + Impuestos",
          value: data.arsPriceWithTaxes,
          symbol: "\$",
          valueSize: 22,
        ),
        CardValue(
          title: "Dólares Estadounidenses",
          value: data.usdPrice,
          symbol: "US\$",
          valueSize: 22,
        ),
      ],
      logo: CardLogo(
        iconData: iconData,
        iconAsset: iconAsset,
        tag: tag,
      ),
      lastUpdated: CardLastUpdated(
        timestamp: data.timestamp,
      ),
      gradiantColors: gradiantColors,
    );
  }
}
