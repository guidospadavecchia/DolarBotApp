import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/bcra_info/bcra_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuBCRA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'BCRA';

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
            Util.navigateTo(
              context,
              BcraInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Riesgo País",
                  tag: _title,
                  iconData: FontAwesomeIcons.chartLine,
                  colors: DolarBotConstants.kGradiantBCRA,
                  endpoint: BcraEndpoints.riesgoPais.value,
                  response: CountryRiskResponse,
                ),
                //bcraEndpoint: BcraEndpoints.riesgoPais,
              ),
            )
          },
        ),
        MenuItem(
          text: "Reservas",
          leading: getIconData(context, FontAwesomeIcons.handHoldingUsd),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              BcraInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Reservas",
                  subtitle: "Dólares Estadounidenses",
                  symbol: "US\$",
                  tag: _title,
                  iconData: FontAwesomeIcons.handHoldingUsd,
                  colors: DolarBotConstants.kGradiantBCRA,
                  endpoint: BcraEndpoints.reservas.value,
                  response: BcraResponse,
                ),
                //bcraEndpoint: BcraEndpoints.reservas,
              ),
            )
          },
        ),
        MenuItem(
          text: "Circulante",
          leading: getIconData(context, FontAwesomeIcons.moneyBillWave),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              BcraInfoScreen(
                title: _title,
                cardData: CardData(
                  title: 'Dinero en Circulación',
                  subtitle: 'Pesos Argentinos',
                  symbol: '\$',
                  tag: _title,
                  iconData: FontAwesomeIcons.moneyBillWave,
                  colors: DolarBotConstants.kGradiantBCRA,
                  endpoint: BcraEndpoints.circulante.value,
                  response: BcraResponse,
                ),
                //bcraEndpoint: BcraEndpoints.circulante,
              ),
            ),
          },
        ),
      ],
    );
  }
}