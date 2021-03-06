import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/base/base_card_template.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';

class FiatCurrencyCard extends BaseCardTemplate {
  static const double height = 140;

  final String title;
  final String tag;
  final GenericCurrencyResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;

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
    @required this.endpoint,
  }) : super(
          title: title,
          tag: tag,
          gradiantColors: gradiantColors,
          iconAsset: iconAsset,
          iconData: iconData,
          showPoweredBy: showPoweredBy,
          showButtons: showButtons,
          endpoint: endpoint,
        );

  @override
  _FiatCurrencyCardState createState() => _FiatCurrencyCardState(data);
}

class _FiatCurrencyCardState extends BaseCardTemplateState<FiatCurrencyCard> {
  final GenericCurrencyResponse data;

  _FiatCurrencyCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: FiatCurrencyCard.height,
      showPoweredBy: showPoweredBy,
      header: CardHeader(
        title: widget.title,
        showButtons: showButtons,
        onTapFavorite: () => onTapFavorite(),
        onTapShare: () => onTapShare(),
      ),
      spaceBetweenItems: Spacing.small,
      spaceBetweenHeader: Spacing.medium,
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
        iconData: widget.iconData,
        iconAsset: widget.iconAsset,
        tag: widget.tag,
      ),
      lastUpdated: CardLastUpdated(
        timestamp: data.timestamp,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}
