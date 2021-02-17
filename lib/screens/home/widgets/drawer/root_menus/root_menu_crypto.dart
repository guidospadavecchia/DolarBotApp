import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/screens/crypto_info/crypto_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuCrypto extends StatelessWidget {
  final Function onRefresh;

  const RootMenuCrypto({
    Key key,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuItem(
      text: "Crypto",
      leading: getIconData(context, CryptoFontIcons.TRIG),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Bitcoin",
          leading: getIconData(context, CryptoFontIcons.BTC),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Bitcoin (BTC)',
                bodyContent: CryptoInfoScreen(
                  cryptoEndpoint: CryptoEndpoints.bitcoin,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
        MenuItem(
          text: "Bitcoin Cash",
          leading: getIconData(context, CryptoFontIcons.BTC_ALT),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Bitcoin Cash (BCH)',
                bodyContent: CryptoInfoScreen(
                  cryptoEndpoint: CryptoEndpoints.bitcoincash,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
        MenuItem(
          text: "DASH",
          leading: getIconData(context, CryptoFontIcons.DASH),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'DASH',
                bodyContent: CryptoInfoScreen(
                  cryptoEndpoint: CryptoEndpoints.dash,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
        MenuItem(
          text: "Ethereum",
          leading: getIconData(context, FontAwesomeIcons.ethereum),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Ethereum (ETH)',
                bodyContent: CryptoInfoScreen(
                  cryptoEndpoint: CryptoEndpoints.ethereum,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
        MenuItem(
          text: "Litecoin",
          leading: getIconData(context, CryptoFontIcons.LTC),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Litecoin (LTC)',
                bodyContent: CryptoInfoScreen(
                  cryptoEndpoint: CryptoEndpoints.litecoin,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
        MenuItem(
          text: "Monero",
          leading: getIconData(context, CryptoFontIcons.XMR),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Monero (XMR)',
                bodyContent: CryptoInfoScreen(
                  cryptoEndpoint: CryptoEndpoints.monero,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
        MenuItem(
          text: "Ripple",
          leading: getIconData(context, CryptoFontIcons.XRP),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Ripple (XRP)',
                bodyContent: CryptoInfoScreen(
                  cryptoEndpoint: CryptoEndpoints.ripple,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
      ],
    );
  }
}
