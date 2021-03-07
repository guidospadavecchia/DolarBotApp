import 'package:dolarbot_app/api/responses/cryptoResponse.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/base/base_card_template.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/cryptoResponse.dart';

class CryptoCard extends BaseCardTemplate {
  static const double height = 270;

  final GlobalKey<HomeScreenState> homeKey;
  final String title;
  final String tag;
  final CryptoResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;

  const CryptoCard({
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
  _CryptoCardState createState() => _CryptoCardState(data);
}

class _CryptoCardState extends BaseCardTemplateState<CryptoCard> {
  final CryptoResponse data;

  _CryptoCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: CryptoCard.height,
      header: CardHeader(
        title: widget.title,
        showButtons: showButtons,
        onFavoritePressed: () => onFavoritePressed(),
        onSharePressed: () => onSharePressed(),
      ),
      spaceBetweenHeader: Spacing.medium,
      spaceBetweenItems: Spacing.medium,
      direction: Axis.vertical,
      rates: [
        CardValue(
          title: "Pesos Argentinos",
          value: data.arsPrice,
          symbol: "\$",
          titleSize: 16,
          valueSize: 22,
        ),
        CardValue(
          title: "Pesos Argentinos + Impuestos",
          value: data.arsPriceWithTaxes,
          symbol: "\$",
          titleSize: 16,
          valueSize: 22,
        ),
        CardValue(
          title: "Dólares Estadounidenses",
          value: data.usdPrice,
          symbol: "US\$",
          titleSize: 16,
          valueSize: 22,
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
