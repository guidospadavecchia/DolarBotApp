import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/euroResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuEuro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: 'Euro - Banco BBVA',
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
            navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: 'Euro - Nuevo Banco del Chaco',
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
            navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: 'Euro - Banco Galicia',
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
            navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: 'Euro - Banco Hipotecario',
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
            navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: 'Euro - Banco de La Pampa',
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
            navigateTo(
              context,
              FiatCurrencyInfoScreen<EuroResponse>(
                title: 'Euro - Banco Nación',
                euroEndpoint: EuroEndpoints.nacion,
              ),
            )
          },
        ),
      ],
    );
  }
}
