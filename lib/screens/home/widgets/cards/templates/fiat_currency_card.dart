import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';

class FiatCurrencyCard extends StatelessWidget {
  final String title;
  final String tag;
  final IconData iconData;
  final String iconAsset;
  final List<Color> gradiantColors;
  final GenericCurrencyResponse data;

  const FiatCurrencyCard({
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
      header: CardHeader(
        title: title,
        showButtons: false,
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
