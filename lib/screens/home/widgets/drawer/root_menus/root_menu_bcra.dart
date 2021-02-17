import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/screens/bcra_info/bcra_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuBCRA extends StatelessWidget {
  final Function onRefresh;

  const RootMenuBCRA({
    Key key,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuItem(
      text: "Indicadores BCRA",
      leading: getIconData(context, FontAwesomeIcons.chartLine),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Riesgo País",
          leading: getIconData(context, FontAwesomeIcons.exclamationTriangle),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Riesgo País',
                bodyContent: BcraInfoScreen(
                  bcraEndpoint: BcraEndpoints.riesgoPais,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
        MenuItem(
          text: "Reservas",
          leading: getIconData(context, FontAwesomeIcons.handHoldingUsd),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Reservas del BCRA',
                bodyContent: BcraInfoScreen(
                  bcraEndpoint: BcraEndpoints.reservas,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
        MenuItem(
          text: "Circulante",
          leading: getIconData(context, FontAwesomeIcons.moneyBillWave),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
                context: context,
                title: 'Dinero en circulación',
                bodyContent: BcraInfoScreen(
                  bcraEndpoint: BcraEndpoints.circulante,
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
      ],
    );
  }
}
