import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/euro_response.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuEuro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Euro';

    return MenuItem(
      text: "Euro",
      leading: getIconData(context, FontAwesomeIcons.euroSign),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: _title,
                cardData: CardData(
                  title: "Banco BBVA",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.bbva,
                  colors: DolarBotConstants.kGradiantBBVA,
                  endpoint: EuroEndpoints.bbva.value,
                  response: EuroResponse,
                ),
                euroEndpoint: EuroEndpoints.bbva,
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
              FiatCurrencyInfoScreen<EuroResponse>(
                title: _title,
                cardData: CardData(
                  title: "Nuevo Banco del Chaco",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.chaco,
                  colors: DolarBotConstants.kGradiantChaco,
                  endpoint: EuroEndpoints.chaco.value,
                  response: EuroResponse,
                ),
                euroEndpoint: EuroEndpoints.chaco,
              ),
            )
          },
        ),
        MenuItem(
          text: "Galicia",
          leading: getIconAsset(context, DolarBotIcons.banks.galicia),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: _title,
                cardData: CardData(
                  title: "Banco Galicia",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.galicia,
                  colors: DolarBotConstants.kGradiantGalicia,
                  endpoint: EuroEndpoints.galicia.value,
                  response: EuroResponse,
                ),
                euroEndpoint: EuroEndpoints.galicia,
              ),
            )
          },
        ),
        MenuItem(
          text: "Hipotecario",
          leading: getIconAsset(context, DolarBotIcons.banks.hipotecario),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: _title,
                cardData: CardData(
                  title: "Banco Hipotecario",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.hipotecario,
                  colors: DolarBotConstants.kGradiantHipotecario,
                  endpoint: EuroEndpoints.hipotecario.value,
                  response: EuroResponse,
                ),
                euroEndpoint: EuroEndpoints.hipotecario,
              ),
            )
          },
        ),
        MenuItem(
          text: "La Pampa",
          leading: getIconAsset(context, DolarBotIcons.banks.pampa),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: _title,
                cardData: CardData(
                  title: "Banco de La Pampa",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.pampa,
                  colors: DolarBotConstants.kGradiantPampa,
                  endpoint: EuroEndpoints.pampa.value,
                  response: EuroResponse,
                ),
                euroEndpoint: EuroEndpoints.pampa,
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
              FiatCurrencyInfoScreen<EuroResponse>(
                title: _title,
                cardData: CardData(
                  title: "Banco Nación",
                  tag: _title,
                  iconAsset: DolarBotIcons.banks.nacion,
                  colors: DolarBotConstants.kGradiantNacion,
                  endpoint: EuroEndpoints.nacion.value,
                  response: EuroResponse,
                ),
                euroEndpoint: EuroEndpoints.nacion,
              ),
            )
          },
        ),
      ],
    );
  }
}
