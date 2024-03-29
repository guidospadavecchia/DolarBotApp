import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../api/api_endpoints.dart';
import '../../../api/responses/base/api_response.dart';
import '../../../classes/app_config.dart';
import '../../../classes/dolarbot_icons.dart';
import '../../../screens/crypto_info/crypto_info_screen.dart';
import '../../../util/constants.dart';
import '../../cards/factory/card_data.dart';
import '../../common/menu_item.dart';
import '../drawer_menu_body.dart';

const String _title = "Crypto";

class RootMenuCrypto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuItem(
      text: "Crypto",
      leading: getIconAsset(context, DolarBotIcons.general.crypto),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "Bitcoin",
          leading: getIconData(context, CryptoFontIcons.BTC),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Bitcoin (BTC)",
                  tag: _title,
                  iconData: CryptoFontIcons.BTC,
                  colors: DolarBotConstants.kGradiantBitcoin,
                  endpoint: CryptoEndpoints.bitcoin.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Bitcoin Cash",
          leading: getIconData(context, CryptoFontIcons.BTC_ALT),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Bitcoin Cash (BCH)",
                  tag: _title,
                  iconData: CryptoFontIcons.BTC_ALT,
                  colors: DolarBotConstants.kGradiantBitcoinCash,
                  endpoint: CryptoEndpoints.bitcoincash.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Binance Coin",
          leading: getIconAsset(context, DolarBotIcons.crypto.binance),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Binance Coin (BNB)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.binance,
                  colors: DolarBotConstants.kGradiantBinanceCoin,
                  endpoint: CryptoEndpoints.binance.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Cardano",
          leading: getIconAsset(context, DolarBotIcons.crypto.cardano),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Cardano (ADA)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.cardano,
                  colors: DolarBotConstants.kGradiantCardano,
                  endpoint: CryptoEndpoints.cardano.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Chainlink",
          leading: getIconAsset(context, DolarBotIcons.crypto.chainlink),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Chainlink (LINK)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.chainlink,
                  colors: DolarBotConstants.kGradiantChainlink,
                  endpoint: CryptoEndpoints.chainlink.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "DAI",
          leading: getIconAsset(context, DolarBotIcons.crypto.dai),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "DAI (DAI)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.dai,
                  colors: DolarBotConstants.kGradiantDAI,
                  endpoint: CryptoEndpoints.dai.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "DASH",
          leading: getIconData(context, CryptoFontIcons.DASH),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "DASH (DASH)",
                  tag: _title,
                  iconData: CryptoFontIcons.DASH,
                  colors: DolarBotConstants.kGradiantDASH,
                  endpoint: CryptoEndpoints.dash.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Dogecoin",
          leading: getIconData(context, CryptoFontIcons.DOGE),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Dogecoin (DOGE)",
                  tag: _title,
                  iconData: CryptoFontIcons.DOGE,
                  colors: DolarBotConstants.kGradiantDoge,
                  endpoint: CryptoEndpoints.dogecoin.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Ethereum",
          leading: getIconData(context, FontAwesomeIcons.ethereum),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: 'Ethereum (ETH)',
                  tag: _title,
                  iconData: CryptoFontIcons.ETH,
                  colors: DolarBotConstants.kGradiantEthereum,
                  endpoint: CryptoEndpoints.ethereum.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Litecoin",
          leading: getIconData(context, CryptoFontIcons.LTC),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: 'Litecoin (LTC)',
                  tag: _title,
                  iconData: CryptoFontIcons.LTC,
                  colors: DolarBotConstants.kGradiantLitecoin,
                  endpoint: CryptoEndpoints.litecoin.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Monero",
          leading: getIconData(context, CryptoFontIcons.XMR),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: 'Monero (XMR)',
                  tag: _title,
                  iconData: CryptoFontIcons.XMR,
                  colors: DolarBotConstants.kGradiantMonero,
                  endpoint: CryptoEndpoints.monero.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Polkadot",
          leading: getIconAsset(context, DolarBotIcons.crypto.polkadot),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Polkadot (DOT)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.polkadot,
                  colors: DolarBotConstants.kGradiantPolkadot,
                  endpoint: CryptoEndpoints.polkadot.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Ripple",
          leading: getIconData(context, CryptoFontIcons.XRP),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: 'Ripple (XRP)',
                  tag: _title,
                  iconData: CryptoFontIcons.XRP,
                  colors: DolarBotConstants.kGradiantRipple,
                  endpoint: CryptoEndpoints.ripple.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Stellar",
          leading: getIconAsset(context, DolarBotIcons.crypto.stellar),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Stellar (XLM)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.stellar,
                  colors: DolarBotConstants.kGradiantStellar,
                  endpoint: CryptoEndpoints.stellar.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Tether",
          leading: getIconAsset(context, DolarBotIcons.crypto.tether),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Tether (USDT)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.tether,
                  colors: DolarBotConstants.kGradiantTether,
                  endpoint: CryptoEndpoints.tether.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Theta",
          leading: getIconAsset(context, DolarBotIcons.crypto.theta),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Theta (THETA)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.theta,
                  colors: DolarBotConstants.kGradiantTheta,
                  endpoint: CryptoEndpoints.theta.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Uniswap",
          leading: getIconAsset(context, DolarBotIcons.crypto.uniswap),
          lockedBehindProFeature: !AppConfig.isProVersion,
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Uniswap (UNI)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.uniswap,
                  colors: DolarBotConstants.kGradiantUniswap,
                  endpoint: CryptoEndpoints.uniswap.value,
                  responseType: CryptoResponse,
                ),
              ),
            )
          },
        ),
      ],
    );
  }
}
