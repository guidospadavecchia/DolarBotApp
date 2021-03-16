import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:intl/intl.dart';

export 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';

class FiatCurrencyCard extends BaseCard {
  static const double height = 150;

  final String title;
  final String tag;
  final GenericCurrencyResponse data;
  final List<Color> gradiantColors;
  final IconData iconData;
  final String iconAsset;
  final bool showPoweredBy;
  final bool showShareButton;
  final String endpoint;
  final Tuple2<NumberFormat, String> numberFormat;

  const FiatCurrencyCard(
      {Key key,
      @required this.title,
      @required this.tag,
      @required this.data,
      @required this.gradiantColors,
      this.iconData,
      this.iconAsset,
      this.showPoweredBy = false,
      this.showShareButton = true,
      @required this.endpoint,
      @required this.numberFormat})
      : super(
          title: title,
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
  _FiatCurrencyCardState createState() => _FiatCurrencyCardState(data);
}

class _FiatCurrencyCardState extends BaseCardState<FiatCurrencyCard> {
  final GenericCurrencyResponse data;

  _FiatCurrencyCardState(this.data);

  @override
  Widget card() {
    return CardFavorite(
      height: FiatCurrencyCard.height,
      header: CardHeader(
        title: widget.title,
        shareButton:
            widget.showShareButton ? CardShareButton(onSharePressed: () => onSharePressed()) : null,
      ),
      spaceBetweenItems: Spacing.small,
      spaceBetweenHeader: (data.sellPriceWithTaxes != null) ? Spacing.medium : Spacing.small,
      rates: [
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Compra",
          value: data.buyPrice,
          symbol: "\$",
          titleSize: data.sellPriceWithTaxes == null ? 16 : 16,
          valueSize: data.sellPriceWithTaxes == null ? 26 : 18,
        ),
        CardValue(
          numberFormat: widget.numberFormat,
          title: "Venta",
          value: data.sellPrice,
          symbol: "\$",
          titleSize: data.sellPriceWithTaxes == null ? 16 : 16,
          valueSize: data.sellPriceWithTaxes == null ? 26 : 18,
        ),
        if (data.sellPriceWithTaxes != null)
          CardValue(
            numberFormat: widget.numberFormat,
            title: "Ahorro",
            titleSize: 16,
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
        showPoweredBy: widget.showPoweredBy,
      ),
      gradiantColors: widget.gradiantColors,
    );
  }
}
