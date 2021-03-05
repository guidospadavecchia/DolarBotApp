import 'package:dolarbot_app/api/responses/cryptoResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/cryptoResponse.dart';

class CryptoCard extends StatelessWidget {
  final String title;
  final String tag;
  final CryptoResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;

  const CryptoCard({
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
      height: 270,
      header: CardHeader(
        title: title,
        showButtons: showButtons,
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
