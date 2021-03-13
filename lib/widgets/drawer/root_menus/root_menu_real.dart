import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/real_response.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';

class RootMenuReal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Real';

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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: _title,
                cardData: CardData(
                  title: "Banco BBVA",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.bbva,
                  colors: DolarBotConstants.kGradiantBBVA,
                  endpoint: RealEndpoints.bbva.value,
                  response: RealResponse,
                ),
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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: _title,
                cardData: CardData(
                  title: "Nuevo Banco del Chaco",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.chaco,
                  colors: DolarBotConstants.kGradiantChaco,
                  endpoint: RealEndpoints.chaco.value,
                  response: RealResponse,
                ),
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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: _title,
                cardData: CardData(
                  title: "Banco Nación",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.nacion,
                  colors: DolarBotConstants.kGradiantNacion,
                  endpoint: RealEndpoints.nacion.value,
                  response: RealResponse,
                ),
                realEndpoint: RealEndpoints.nacion,
              ),
            )
          },
        ),
      ],
    );
  }
}
