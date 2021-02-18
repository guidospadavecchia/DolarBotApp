import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/screens/crypto_info/crypto_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuCrypto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<CryptoInfoScreenState> _key = GlobalKey();
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
            buildContentAndPush(
              context: context,
              title: 'Bitcoin (BTC)',
              bodyContent: CryptoInfoScreen(
                cryptoEndpoint: CryptoEndpoints.bitcoin,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Bitcoin Cash",
          leading: getIconData(context, CryptoFontIcons.BTC_ALT),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Bitcoin Cash (BCH)',
              bodyContent: CryptoInfoScreen(
                cryptoEndpoint: CryptoEndpoints.bitcoincash,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "DASH",
          leading: getIconData(context, CryptoFontIcons.DASH),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'DASH',
              bodyContent: CryptoInfoScreen(
                cryptoEndpoint: CryptoEndpoints.dash,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Ethereum",
          leading: getIconData(context, FontAwesomeIcons.ethereum),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Ethereum (ETH)',
              bodyContent: CryptoInfoScreen(
                cryptoEndpoint: CryptoEndpoints.ethereum,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Litecoin",
          leading: getIconData(context, CryptoFontIcons.LTC),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Litecoin (LTC)',
              bodyContent: CryptoInfoScreen(
                cryptoEndpoint: CryptoEndpoints.litecoin,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Monero",
          leading: getIconData(context, CryptoFontIcons.XMR),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Monero (XMR)',
              bodyContent: CryptoInfoScreen(
                cryptoEndpoint: CryptoEndpoints.monero,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Ripple",
          leading: getIconData(context, CryptoFontIcons.XRP),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Ripple (XRP)',
              bodyContent: CryptoInfoScreen(
                cryptoEndpoint: CryptoEndpoints.ripple,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
      ],
    );
  }
}
