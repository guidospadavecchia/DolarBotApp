import 'package:dolarbot_app/api/responses/crypto_response.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/crypto_response.dart';

class CryptoCard extends BaseCard {
  static const double height = 270;

  final String title;
  final String bannerTitle;
  final String tag;
  final CryptoResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showShareButton;
  final String endpoint;
  final NumberFormat numberFormat;

  const CryptoCard({
    Key key,
    @required this.title,
    @required this.bannerTitle,
    @required this.tag,
    @required this.data,
    @required this.gradiantColors,
    this.iconData,
    this.iconAsset,
    this.showPoweredBy = false,
    this.showShareButton = true,
    @required this.endpoint,
    @required this.numberFormat,
  }) : super(
          title: title,
          bannerTitle: bannerTitle,
          tag: tag,
          gradiantColors: gradiantColors,
          iconAsset: iconAsset,
          iconData: iconData,
          showPoweredBy: showPoweredBy,
          showShareButton: showShareButton,
          endpoint: endpoint,
          numberFormat: numberFormat,
        );

  @override
  _CryptoCardState createState() => _CryptoCardState(data);
}

class _CryptoCardState extends BaseCardState<CryptoCard> {
  final CryptoResponse data;

  _CryptoCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: CryptoCard.height,
      header: CardHeader(
        title: widget.bannerTitle,
        shareButton:
            widget.showShareButton ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
      ),
      spaceBetweenHeader: Spacing.medium,
      spaceBetweenItems: Spacing.medium,
      direction: Axis.vertical,
      rates: [
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Pesos Argentinos",
          value: data.arsPrice,
          symbol: "\$",
          titleSize: 16,
          valueSize: 22,
        ),
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Pesos Argentinos + Impuestos",
          value: data.arsPriceWithTaxes,
          symbol: "\$",
          titleSize: 16,
          valueSize: 22,
        ),
        CardValue(
          numberFormat: widget.numberFormat,
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
        showPoweredBy: widget.showPoweredBy,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}
