import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/realResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/currency_info/currency_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';

class RootMenuReal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<CurrencyInfoScreenState> _key = GlobalKey();

    return MenuItem(
      text: "Real",
      leading: getIconAsset(context, DolarBotIcons.general.real),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context: context,
              title: 'Real - Banco BBVA',
              bodyContent: CurrencyInfoScreen<RealResponse>(
                realEndpoint: RealEndpoints.bbva,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Chaco",
          leading: getIconAsset(context, DolarBotIcons.banks.chaco),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context: context,
              title: 'Real - Nuevo Banco del Chaco',
              bodyContent: CurrencyInfoScreen<RealResponse>(
                realEndpoint: RealEndpoints.chaco,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Nación",
          leading: getIconAsset(context, DolarBotIcons.banks.nacion),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context: context,
              title: 'Real - Banco Nación',
              bodyContent: CurrencyInfoScreen<RealResponse>(
                realEndpoint: RealEndpoints.nacion,
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
