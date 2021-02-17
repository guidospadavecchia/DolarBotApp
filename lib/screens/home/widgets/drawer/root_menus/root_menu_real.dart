import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/realResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/currency_info/currency_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';

class RootMenuReal extends StatelessWidget {
  final Function onRefresh;

  const RootMenuReal({
    Key key,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  key: key,
                ),
                onRefresh: onRefresh)
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
                  key: key,
                ),
                onRefresh: onRefresh)
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
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
      ],
    );
  }
}
