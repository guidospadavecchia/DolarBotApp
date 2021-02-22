import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/realResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';

class RootMenuReal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuItem(
      text: "Real",
      leading: getIconAsset(context, DolarBotIcons.general.real),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: 'Real - Banco BBVA',
                realEndpoint: RealEndpoints.bbva,
              ),
            )
          },
        ),
        MenuItem(
          text: "Chaco",
          leading: getIconAsset(context, DolarBotIcons.banks.chaco),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: 'Real - Nuevo Banco del Chaco',
                realEndpoint: RealEndpoints.chaco,
              ),
            )
          },
        ),
        MenuItem(
          text: "Nación",
          leading: getIconAsset(context, DolarBotIcons.banks.nacion),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: 'Real - Banco Nación',
                realEndpoint: RealEndpoints.nacion,
              ),
            )
          },
        ),
      ],
    );
  }
}
