import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/base/base_card_template.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';

class FiatCurrencyCard extends BaseCardTemplate {
  static const double height = 145;

  final GlobalKey<HomeScreenState> homeKey;
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
    this.homeKey,
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
          homeKey: homeKey,
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
      header: CardHeader(
        title: widget.title,
        showButtons: showButtons,
        onRemovePressed: () => onRemovePressed(),
        onSharePressed: () => onSharePressed(),
      ),
      spaceBetweenItems: Spacing.small,
      spaceBetweenHeader: Spacing.small,
      rates: [
        CardValue(
          title: "Compra",
          value: data.buyPrice,
          symbol: "\$",
          titleSize: data.sellPriceWithTaxes == null ? 16 : 14,
          valueSize: data.sellPriceWithTaxes == null ? 26 : 18,
        ),
        CardValue(
          title: "Venta",
          value: data.sellPrice,
          symbol: "\$",
          titleSize: data.sellPriceWithTaxes == null ? 16 : 14,
          valueSize: data.sellPriceWithTaxes == null ? 26 : 18,
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
        showPoweredBy: showPoweredBy,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}
