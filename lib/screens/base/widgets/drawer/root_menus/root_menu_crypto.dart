import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/classes/constants.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/crypto_info/crypto_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuCrypto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Crypto';

    return MenuItem(
      text: "Crypto",
      leading: getIconData(context, CryptoFontIcons.TRIG),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "Bitcoin",
          leading: getIconData(context, CryptoFontIcons.BTC),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              CryptoInfoScreen(
                title: _title,
                headerIconData: CryptoFontIcons.BTC,
                headerTitle: "Bitcoin (BTC)",
                gradiantColors: DolarBotConstants.kGradiantBitcoin,
                cryptoEndpoint: CryptoEndpoints.bitcoin,
              ),
            )
          },
        ),
        MenuItem(
          text: "Bitcoin Cash",
          leading: getIconData(context, CryptoFontIcons.BTC_ALT),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              CryptoInfoScreen(
                title: 'Crypto',
                headerIconData: CryptoFontIcons.BTC_ALT,
                headerTitle: "Bitcoin Cash (BCH)",
                gradiantColors: DolarBotConstants.kGradiantBitcoinCash,
                cryptoEndpoint: CryptoEndpoints.bitcoincash,
              ),
            )
          },
        ),
        MenuItem(
          text: "DASH",
          leading: getIconData(context, CryptoFontIcons.DASH),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              CryptoInfoScreen(
                title: 'Crypto',
                headerIconData: CryptoFontIcons.DASH,
                headerTitle: 'DASH',
                gradiantColors: DolarBotConstants.kGradiantDASH,
                cryptoEndpoint: CryptoEndpoints.dash,
              ),
            )
          },
        ),
        MenuItem(
          text: "Ethereum",
          leading: getIconData(context, FontAwesomeIcons.ethereum),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              CryptoInfoScreen(
                title: 'Crypto',
                headerIconData: CryptoFontIcons.ETH,
                headerTitle: 'Ethereum (ETH)',
                gradiantColors: DolarBotConstants.kGradiantEthereum,
                cryptoEndpoint: CryptoEndpoints.ethereum,
              ),
            )
          },
        ),
        MenuItem(
          text: "Litecoin",
          leading: getIconData(context, CryptoFontIcons.LTC),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              CryptoInfoScreen(
                  title: 'Crypto',
                  headerIconData: CryptoFontIcons.LTC,
                  headerTitle: 'Litecoin (LTC)',
                  gradiantColors: DolarBotConstants.kGradiantLitecoin,
                  cryptoEndpoint: CryptoEndpoints.litecoin),
            )
          },
        ),
        MenuItem(
          text: "Monero",
          leading: getIconData(context, CryptoFontIcons.XMR),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              CryptoInfoScreen(
                title: 'Crypto',
                headerIconData: CryptoFontIcons.XMR,
                headerTitle: 'Monero (XMR)',
                gradiantColors: DolarBotConstants.kGradiantMonero,
                cryptoEndpoint: CryptoEndpoints.monero,
              ),
            )
          },
        ),
        MenuItem(
          text: "Ripple",
          leading: getIconData(context, CryptoFontIcons.XRP),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              CryptoInfoScreen(
                title: 'Crypto',
                headerIconData: CryptoFontIcons.XRP,
                headerTitle: 'Ripple (XRP)',
                gradiantColors: DolarBotConstants.kGradiantRipple,
                cryptoEndpoint: CryptoEndpoints.ripple,
              ),
            )
          },
        ),
      ],
    );
  }
}
