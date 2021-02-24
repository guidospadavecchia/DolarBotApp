import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/bcra_info/bcra_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuBCRA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuItem(
      text: "Indicadores BCRA",
      leading: getIconData(context, FontAwesomeIcons.chartLine),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "Riesgo País",
          leading: getIconData(context, FontAwesomeIcons.exclamationTriangle),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              BcraInfoScreen(
                title: 'Riesgo País',
                bcraEndpoint: BcraEndpoints.riesgoPais,
              ),
            )
          },
        ),
        MenuItem(
          text: "Reservas",
          leading: getIconData(context, FontAwesomeIcons.handHoldingUsd),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              BcraInfoScreen(
                title: 'Reservas del BCRA',
                bcraEndpoint: BcraEndpoints.reservas,
              ),
            )
          },
        ),
        MenuItem(
          text: "Circulante",
          leading: getIconData(context, FontAwesomeIcons.moneyBillWave),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              BcraInfoScreen(
                title: 'Dinero en circulación',
                bcraEndpoint: BcraEndpoints.circulante,
              ),
            ),
          },
        ),
      ],
    );
  }
}