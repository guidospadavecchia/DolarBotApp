import 'package:flutter/material.dart';

import '../../../api/responses/base/generic_currency_response.dart';
import '../../../classes/size_config.dart';
import '../../../screens/base/base_info_screen.dart';
import '../card_favorite.dart';
import 'base/base_card.dart';

export 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';

class FiatCurrencyCard<T extends GenericCurrencyResponse> extends BaseCard {
  static const double kHeight = 150;

  final String title;
  final String bannerTitle;
  final String tag;
  final bool coloredTag;
  final T data;
  final List<Color> gradiantColors;
  final IconData? iconData;
  final String? iconAsset;
  final bool showPoweredBy;
  final bool showButtons;
  final String endpoint;
  final NumberFormat numberFormat;

  const FiatCurrencyCard(
      {Key? key,
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
      required this.numberFormat})
      : super(
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
  _FiatCurrencyCardState createState() => _FiatCurrencyCardState(data);
}

class _FiatCurrencyCardState extends BaseCardState<FiatCurrencyCard> {
  final GenericCurrencyResponse data;

  _FiatCurrencyCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: FiatCurrencyCard.kHeight,
      header: CardHeader(
        title: widget.bannerTitle,
        titleFontSize: SizeConfig.blockSizeVertical * 2.8,
        shareButton: widget.showButtons ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
      ),
      spaceBetweenItems: Spacing.small,
      spaceBetweenHeader: (data.sellPriceWithTaxes != null) ? Spacing.medium : Spacing.small,
      rates: [
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Compra",
          value: data.buyPrice,
          symbol: "\$",
          spaceBetweenTitle: Spacing.small,
          titleSize: SizeConfig.blockSizeVertical * 2,
          valueSize: data.sellPriceWithTaxes == null ? SizeConfig.blockSizeVertical * 3 : SizeConfig.blockSizeVertical * 2.1,
        ),
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Venta",
          value: data.sellPrice,
          symbol: "\$",
          spaceBetweenTitle: Spacing.small,
          titleSize: SizeConfig.blockSizeVertical * 2,
          valueSize: data.sellPriceWithTaxes == null ? SizeConfig.blockSizeVertical * 3 : SizeConfig.blockSizeVertical * 2.1,
        ),
        if (data.sellPriceWithTaxes != null)
          CardValue(
            numberFormat: widget.numberFormat,
            title: "Ahorro",
            value: data.sellPriceWithTaxes,
            symbol: "\$",
            spaceBetweenTitle: Spacing.small,
            titleSize: SizeConfig.blockSizeVertical * 2,
            valueSize: SizeConfig.blockSizeVertical * 2.1,
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
