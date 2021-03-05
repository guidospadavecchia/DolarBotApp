import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';

class FiatCurrencyCard extends StatelessWidget {
  static const double height = 140;

  final String title;
  final String tag;
  final GenericCurrencyResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;

  const FiatCurrencyCard({
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
      height: height,
      showPoweredBy: showPoweredBy,
      header: CardHeader(
        title: title,
        showButtons: showButtons,
      ),
      spaceBetweenItems: Spacing.medium,
      spaceBetweenHeader: Spacing.small,
      rates: [
        CardValue(
          title: "Compra",
          value: data.buyPrice,
          symbol: "\$",
          titleSize: data.sellPriceWithTaxes == null ? 16 : 14,
          valueSize: data.sellPriceWithTaxes == null ? 24 : 18,
        ),
        CardValue(
          title: "Venta",
          value: data.sellPrice,
          symbol: "\$",
          titleSize: data.sellPriceWithTaxes == null ? 16 : 14,
          valueSize: data.sellPriceWithTaxes == null ? 24 : 18,
        ),
        if (data.sellPriceWithTaxes != null)
          CardValue(
            title: "Ahorro",
            value: data.sellPriceWithTaxes,
            symbol: "\$",
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
