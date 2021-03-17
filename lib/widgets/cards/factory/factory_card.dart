import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/bcra_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/country_risk_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/crypto_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/empty_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/fiat_currency_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/metal_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/venezuela_card.dart';

abstract class BuildCard {
  factory BuildCard(ApiResponse data) {
    if (data is GenericCurrencyResponse) return _FiatCurrency(data, FiatCurrencyCard.height);
    if (data is CryptoResponse) return _Empty();
    if (data is MetalResponse) return _Metal(data, MetalCard.height);
    if (data is BcraResponse) return _Bcra(data, BcraCard.height);
    if (data is CountryRiskResponse) return _CountryRisk(data, CountryRiskCard.height);
    if (data is VenezuelaResponse) return _Venezuela(data, VenezuelaCard.height);

    return _Empty();
  }

  BaseCard fromCardData(BuildContext context, CardData buildCardData, Settings settings);
  BaseCard fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate, Settings settings);
}

class _Empty implements BuildCard {
  @override
  BaseCard fromCardData(BuildContext context, CardData buildCardData, Settings settings) {
    return EmptyCard();
  }

  @override
  BaseCard fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate, Settings settings) {
    return EmptyCard();
  }
}

class _FiatCurrency implements BuildCard {
  final GenericCurrencyResponse data;
  final double height;

  _FiatCurrency(this.data, this.height);

  @override
  BaseCard fromCardData(context, buildCardData, Settings settings) {
    return FiatCurrencyCard(
      title: buildCardData.title,
      data: data,
      tag: buildCardData.tag,
      iconAsset: buildCardData.iconAsset,
      iconData: buildCardData.iconData,
      gradiantColors: buildCardData.colors,
      showShareButton: buildCardData.showButtons,
      showPoweredBy: buildCardData.showPoweredBy,
      endpoint: buildCardData.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }

  @override
  BaseCard fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate, Settings settings) {
    return FiatCurrencyCard(
      title: favoriteRate.cardTitle,
      data: data,
      tag: favoriteRate.cardTag,
      iconAsset: favoriteRate.cardIconAsset,
      iconData: IconData(favoriteRate.cardIconData,
          fontFamily: "FontAwesomeSolid", fontPackage: "font_awesome_flutter"),
      gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
      endpoint: favoriteRate.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }
}

class _Crypto implements BuildCard {
  final CryptoResponse data;
  final double height;

  _Crypto(this.data, this.height);

  @override
  BaseCard fromCardData(context, buildCardData, Settings settings) {
    return CryptoCard(
      title: buildCardData.title,
      data: data,
      tag: buildCardData.tag,
      iconAsset: buildCardData.iconAsset,
      iconData: buildCardData.iconData,
      gradiantColors: buildCardData.colors,
      showShareButton: buildCardData.showButtons,
      showPoweredBy: buildCardData.showPoweredBy,
      endpoint: buildCardData.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }

  @override
  BaseCard fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate, Settings settings) {
    return CryptoCard(
      title: favoriteRate.cardTitle,
      data: data,
      tag: favoriteRate.cardTag,
      iconAsset: favoriteRate.cardIconAsset,
      iconData: IconData(favoriteRate.cardIconData,
          fontFamily: 'CryptoFont', fontPackage: 'crypto_font_icons'),
      gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
      endpoint: favoriteRate.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }
}

class _Metal implements BuildCard {
  final MetalResponse data;
  final double height;

  _Metal(this.data, this.height);

  @override
  BaseCard fromCardData(context, buildCardData, Settings settings) {
    return MetalCard(
      title: buildCardData.title,
      data: data,
      tag: buildCardData.tag,
      iconAsset: buildCardData.iconAsset,
      iconData: buildCardData.iconData,
      gradiantColors: buildCardData.colors,
      showShareButton: buildCardData.showButtons,
      showPoweredBy: buildCardData.showPoweredBy,
      endpoint: buildCardData.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }

  @override
  BaseCard fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate, Settings settings) {
    return MetalCard(
      title: favoriteRate.cardTitle,
      data: data,
      tag: favoriteRate.cardTag,
      iconAsset: favoriteRate.cardIconAsset,
      iconData: IconData(favoriteRate.cardIconData),
      gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
      endpoint: favoriteRate.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }
}

class _Bcra implements BuildCard {
  final BcraResponse data;
  final double height;

  _Bcra(this.data, this.height);

  @override
  BaseCard fromCardData(context, buildCardData, Settings settings) {
    return BcraCard(
      title: buildCardData.title,
      subtitle: buildCardData.subtitle,
      symbol: buildCardData.symbol,
      data: data,
      tag: buildCardData.tag,
      iconAsset: buildCardData.iconAsset,
      iconData: buildCardData.iconData,
      gradiantColors: buildCardData.colors,
      showShareButton: buildCardData.showButtons,
      showPoweredBy: buildCardData.showPoweredBy,
      endpoint: buildCardData.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }

  @override
  BaseCard fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate, Settings settings) {
    return BcraCard(
      title: favoriteRate.cardTitle,
      subtitle: favoriteRate.cardSubtitle,
      symbol: favoriteRate.cardSymbol,
      data: data,
      tag: favoriteRate.cardTag,
      iconAsset: favoriteRate.cardIconAsset,
      iconData: IconData(favoriteRate.cardIconData,
          fontFamily: "FontAwesomeSolid", fontPackage: "font_awesome_flutter"),
      gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
      endpoint: favoriteRate.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }
}

class _CountryRisk implements BuildCard {
  final CountryRiskResponse data;
  final double height;

  _CountryRisk(this.data, this.height);

  @override
  BaseCard fromCardData(context, buildCardData, Settings settings) {
    return CountryRiskCard(
      title: buildCardData.title,
      data: data,
      tag: buildCardData.tag,
      iconAsset: buildCardData.iconAsset,
      iconData: buildCardData.iconData,
      gradiantColors: buildCardData.colors,
      showShareButton: buildCardData.showButtons,
      showPoweredBy: buildCardData.showPoweredBy,
      endpoint: buildCardData.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }

  @override
  BaseCard fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate, Settings settings) {
    return CountryRiskCard(
      title: favoriteRate.cardTitle,
      data: data,
      tag: favoriteRate.cardTag,
      iconAsset: favoriteRate.cardIconAsset,
      iconData: IconData(favoriteRate.cardIconData,
          fontFamily: "FontAwesomeSolid", fontPackage: "font_awesome_flutter"),
      gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
      endpoint: favoriteRate.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }
}

class _Venezuela implements BuildCard {
  final VenezuelaResponse data;
  final double height;

  _Venezuela(this.data, this.height);

  @override
  BaseCard fromCardData(context, buildCardData, Settings settings) {
    return VenezuelaCard(
      title: buildCardData.title,
      data: data,
      tag: buildCardData.tag,
      gradiantColors: buildCardData.colors,
      iconAsset: buildCardData.iconAsset,
      iconData: buildCardData.iconData,
      endpoint: buildCardData.endpoint,
      showShareButton: buildCardData.showButtons,
      showPoweredBy: buildCardData.showPoweredBy,
      numberFormat: settings.getNumberFormat(),
    );
  }

  @override
  BaseCard fromFavoriteRate(BuildContext context, FavoriteRate favoriteRate, Settings settings) {
    return VenezuelaCard(
      title: favoriteRate.cardTitle,
      data: data,
      tag: favoriteRate.cardTag,
      gradiantColors: favoriteRate.cardColors.map((n) => Color(n)).toList(),
      iconAsset: favoriteRate.cardIconAsset,
      iconData: IconData(favoriteRate.cardIconData),
      endpoint: favoriteRate.endpoint,
      numberFormat: settings.getNumberFormat(),
    );
  }
}
