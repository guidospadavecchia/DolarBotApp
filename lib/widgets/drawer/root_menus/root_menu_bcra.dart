import '../../../api/api_endpoints.dart';
import '../../../api/responses/base/api_response.dart';
import '../../../util/constants.dart';
import '../drawer_menu_body.dart';
import '../../../screens/bcra_info/bcra_info_screen.dart';
import '../../cards/factory/card_data.dart';
import '../../common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String _title = 'BCRA';

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
            Util.navigateTo(
              context,
              BcraInfoScreen(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Riesgo País",
                  tag: _title,
                  iconData: FontAwesomeIcons.chartLine,
                  colors: DolarBotConstants.kGradiantBCRA,
                  endpoint: BcraEndpoints.riesgoPais.value,
                  responseType: CountryRiskResponse,
                ),
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Reservas",
                  subtitle: "Dólares Estadounidenses",
                  symbol: "US\$",
                  tag: _title,
                  iconData: FontAwesomeIcons.handHoldingUsd,
                  colors: DolarBotConstants.kGradiantBCRA,
                  endpoint: BcraEndpoints.reservas.value,
                  responseType: BcraResponse,
                ),
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: 'Dinero en Circulación',
                  subtitle: 'Pesos Argentinos',
                  symbol: '\$',
                  tag: _title,
                  iconData: FontAwesomeIcons.moneyBillWave,
                  colors: DolarBotConstants.kGradiantBCRA,
                  endpoint: BcraEndpoints.circulante.value,
                  responseType: BcraResponse,
                ),
              ),
            ),
          },
        ),
      ],
    );
  }
}
