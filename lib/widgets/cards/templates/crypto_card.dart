import '../../../api/responses/crypto_response.dart';
import '../../../classes/size_config.dart';
import '../card_favorite.dart';
import 'base/base_card.dart';
import 'package:flutter/material.dart';

export 'package:dolarbot_app/api/responses/crypto_response.dart';

class CryptoCard extends BaseCard {
  static const double kHeight = 270;

  final String title;
  final String bannerTitle;
  final String tag;
  final bool coloredTag;
  final CryptoResponse data;
  final List<Color> gradiantColors;
  final IconData? iconData;
  final String? iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;
  final NumberFormat numberFormat;

  const CryptoCard({
    Key? key,
    required this.title,
    required this.bannerTitle,
    required this.tag,
    required this.coloredTag,
    required this.data,
    required this.gradiantColors,
    this.iconData,
    this.iconAsset,
    this.showPoweredBy = false,
    this.showButtons = true,
    required this.endpoint,
    required this.numberFormat,
  }) : super(
          title: title,
          bannerTitle: bannerTitle,
          tag: tag,
          coloredTag: coloredTag,
          gradiantColors: gradiantColors,
          iconAsset: iconAsset,
          iconData: iconData,
          showPoweredBy: showPoweredBy,
          showButtons: showButtons,
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
      height: CryptoCard.kHeight,
      header: CardHeader(
        title: widget.bannerTitle,
        shareButton: widget.showButtons ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
      ),
      spaceBetweenHeader: Spacing.small,
      spaceBetweenItems: Spacing.small,
      direction: Axis.vertical,
      rates: [
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Dólares Estadounidenses",
          value: data.usdPrice,
          symbol: "US\$",
          spaceBetweenTitle: Spacing.small,
          titleSize: SizeConfig.blockSizeVertical * 2,
          valueSize: SizeConfig.blockSizeVertical * 2.5,
        ),
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Pesos Argentinos",
          value: data.arsPrice,
          symbol: "\$",
          spaceBetweenTitle: Spacing.small,
          titleSize: SizeConfig.blockSizeVertical * 2,
          valueSize: SizeConfig.blockSizeVertical * 2.5,
        ),
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Pesos Argentinos + Impuestos",
          value: data.arsPriceWithTaxes,
          symbol: "\$",
          spaceBetweenTitle: Spacing.small,
          titleSize: SizeConfig.blockSizeVertical * 2,
          valueSize: SizeConfig.blockSizeVertical * 2.5,
        ),
      ],
      logo: CardLogo(
        iconData: widget.iconData,
        iconAsset: widget.iconAsset,
        showDragHandle: widget.showButtons,
        tag: widget.tag,
        coloredTag: widget.coloredTag,
      ),
      lastUpdated: CardLastUpdated(
        timestamp: data.timestamp,
        showPoweredBy: widget.showPoweredBy,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}
