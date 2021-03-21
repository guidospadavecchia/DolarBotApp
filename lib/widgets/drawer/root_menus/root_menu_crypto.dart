import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/crypto_info/crypto_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuCrypto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Crypto';

    return MenuItem(
      text: "Crypto",
      leading: getIconAsset(context, DolarBotIcons.general.crypto),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "Bitcoin",
          leading: getIconData(context, CryptoFontIcons.BTC),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Bitcoin (BTC)",
                  tag: _title,
                  iconData: CryptoFontIcons.BTC,
                  colors: DolarBotConstants.kGradiantBitcoin,
                  endpoint: CryptoEndpoints.bitcoin.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Bitcoin Cash",
          leading: getIconData(context, CryptoFontIcons.BTC_ALT),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Bitcoin Cash (BCH)",
                  tag: _title,
                  iconData: CryptoFontIcons.BTC_ALT,
                  colors: DolarBotConstants.kGradiantBitcoinCash,
                  endpoint: CryptoEndpoints.bitcoincash.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Binance Coin",
          leading: getIconAsset(context, DolarBotIcons.crypto.binance),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Binance Coin (BNB)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.binance,
                  colors: DolarBotConstants.kGradiantBinanceCoin,
                  endpoint: CryptoEndpoints.binance.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Cardano",
          leading: getIconAsset(context, DolarBotIcons.crypto.cardano),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Cardano (ADA)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.cardano,
                  colors: DolarBotConstants.kGradiantCardano,
                  endpoint: CryptoEndpoints.cardano.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Chainlink",
          leading: getIconAsset(context, DolarBotIcons.crypto.chainlink),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Chainlink (LINK)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.chainlink,
                  colors: DolarBotConstants.kGradiantChainlink,
                  endpoint: CryptoEndpoints.chainlink.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "DAI",
          leading: getIconAsset(context, DolarBotIcons.crypto.dai),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "DAI (DAI)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.dai,
                  colors: DolarBotConstants.kGradiantDAI,
                  endpoint: CryptoEndpoints.dai.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "DASH",
          leading: getIconData(context, CryptoFontIcons.DASH),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "DASH (DASH)",
                  tag: _title,
                  iconData: CryptoFontIcons.DASH,
                  colors: DolarBotConstants.kGradiantDASH,
                  endpoint: CryptoEndpoints.dash.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Dogecoin",
          leading: getIconData(context, CryptoFontIcons.DOGE),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Dogecoin (DOGE)",
                  tag: _title,
                  iconData: CryptoFontIcons.DOGE,
                  colors: DolarBotConstants.kGradiantDoge,
                  endpoint: CryptoEndpoints.dogecoin.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Ethereum",
          leading: getIconData(context, FontAwesomeIcons.ethereum),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: 'Ethereum (ETH)',
                  tag: _title,
                  iconData: CryptoFontIcons.ETH,
                  colors: DolarBotConstants.kGradiantEthereum,
                  endpoint: CryptoEndpoints.ethereum.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Litecoin",
          leading: getIconData(context, CryptoFontIcons.LTC),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: 'Litecoin (LTC)',
                  tag: _title,
                  iconData: CryptoFontIcons.LTC,
                  colors: DolarBotConstants.kGradiantLitecoin,
                  endpoint: CryptoEndpoints.litecoin.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Monero",
          leading: getIconData(context, CryptoFontIcons.XMR),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: 'Monero (XMR)',
                  tag: _title,
                  iconData: CryptoFontIcons.XMR,
                  colors: DolarBotConstants.kGradiantMonero,
                  endpoint: CryptoEndpoints.monero.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Polkadot",
          leading: getIconAsset(context, DolarBotIcons.crypto.polkadot),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Polkadot (DOT)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.polkadot,
                  colors: DolarBotConstants.kGradiantPolkadot,
                  endpoint: CryptoEndpoints.polkadot.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Ripple",
          leading: getIconData(context, CryptoFontIcons.XRP),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: 'Ripple (XRP)',
                  tag: _title,
                  iconData: CryptoFontIcons.XRP,
                  colors: DolarBotConstants.kGradiantRipple,
                  endpoint: CryptoEndpoints.ripple.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Stellar",
          leading: getIconAsset(context, DolarBotIcons.crypto.stellar),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Stellar (XLM)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.stellar,
                  colors: DolarBotConstants.kGradiantStellar,
                  endpoint: CryptoEndpoints.stellar.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Tether",
          leading: getIconAsset(context, DolarBotIcons.crypto.tether),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Tether (USDT)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.tether,
                  colors: DolarBotConstants.kGradiantTether,
                  endpoint: CryptoEndpoints.tether.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Theta",
          leading: getIconAsset(context, DolarBotIcons.crypto.theta),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Theta (THETA)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.theta,
                  colors: DolarBotConstants.kGradiantTheta,
                  endpoint: CryptoEndpoints.theta.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Uniswap",
          leading: getIconAsset(context, DolarBotIcons.crypto.uniswap),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Uniswap (UNI)",
                  tag: _title,
                  iconAsset: DolarBotIcons.crypto.uniswap,
                  colors: DolarBotConstants.kGradiantUniswap,
                  endpoint: CryptoEndpoints.uniswap.value,
                  response: CryptoResponse,
                ),
              ),
            )
          },
        ),
      ],
    );
  }
}
