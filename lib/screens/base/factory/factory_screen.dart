import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/bcra_info/bcra_info_screen.dart';
import 'package:dolarbot_app/screens/crypto_info/crypto_info_screen.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/screens/metal_info/metal_info_screen.dart';
import 'package:dolarbot_app/screens/venezuela_info/venezuela_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/templates/bcra_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/country_risk_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/crypto_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/metal_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/venezuela_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class BuildScreen {
  factory BuildScreen(Type responseType) {
    if (responseType == DollarResponse ||
        responseType == EuroResponse ||
        responseType == RealResponse) return _FiatCurrency();
    if (responseType == CryptoResponse) return _Crypto();
    if (responseType == MetalResponse) return _Metal();
    if (responseType == BcraResponse) return _Bcra();
    if (responseType == CountryRiskResponse) return _CountryRisk();
    if (responseType == VenezuelaResponse) return _Venezuela();

    throw 'Unknown ApiResponse type';
  }

  BaseInfoScreen fromCardData(BuildContext context, CardData cardData);
}

class _FiatCurrency implements BuildScreen {
  @override
  BaseInfoScreen fromCardData(BuildContext context, CardData cardData) {
    return FiatCurrencyInfoScreen(
      cardData: cardData,
    );
  }
}

class _Crypto implements BuildScreen {
  @override
  BaseInfoScreen fromCardData(BuildContext context, CardData cardData) {
    return CryptoInfoScreen(
      cardData: cardData,
    );
  }
}

class _Metal implements BuildScreen {
  @override
  BaseInfoScreen fromCardData(BuildContext context, CardData cardData) {
    return MetalInfoScreen(
      cardData: cardData,
    );
  }
}

class _Bcra implements BuildScreen {
  @override
  BaseInfoScreen fromCardData(BuildContext context, CardData cardData) {
    return BcraInfoScreen(
      cardData: cardData,
    );
  }
}

class _CountryRisk implements BuildScreen {
  @override
  BaseInfoScreen fromCardData(BuildContext context, CardData cardData) {
    return BcraInfoScreen(
      cardData: cardData,
    );
  }
}

class _Venezuela implements BuildScreen {
  @override
  BaseInfoScreen fromCardData(BuildContext context, CardData cardData) {
    CardData newCardData = CardData(
        title: cardData.bannerTitle,
        bannerTitle: cardData.title,
        subtitle: cardData.subtitle,
        tag: cardData.tag,
        symbol: cardData.symbol,
        colors: cardData.colors,
        iconAsset: null,
        iconData: cardData.tag == 'Dólar' ? FontAwesomeIcons.dollarSign : FontAwesomeIcons.euroSign,
        showPoweredBy: true,
        showButtons: false,
        endpoint: cardData.endpoint,
        responseType: cardData.responseType);

    return VenezuelaInfoScreen(
      cardData: newCardData,
    );
  }
}
