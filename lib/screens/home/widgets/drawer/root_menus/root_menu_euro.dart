import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/euroResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/currency_info/currency_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuEuro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<CurrencyInfoScreenState> _key = GlobalKey();

    return MenuItem(
      text: "Euro",
      leading: getIconData(context, FontAwesomeIcons.euroSign),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Euro - Banco BBVA',
              bodyContent: CurrencyInfoScreen<EuroResponse>(
                euroEndpoint: EuroEndpoints.bbva,
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
            buildContentAndPush(
              context: context,
              title: 'Euro - Nuevo Banco del Chaco',
              bodyContent: CurrencyInfoScreen<EuroResponse>(
                euroEndpoint: EuroEndpoints.chaco,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Galicia",
          leading: getIconAsset(context, DolarBotIcons.banks.galicia),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Euro - Banco Galicia',
              bodyContent: CurrencyInfoScreen<EuroResponse>(
                euroEndpoint: EuroEndpoints.galicia,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Hipotecario",
          leading: getIconAsset(context, DolarBotIcons.banks.hipotecario),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Euro - Banco Hipotecario',
              bodyContent: CurrencyInfoScreen<EuroResponse>(
                euroEndpoint: EuroEndpoints.hipotecario,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "La Pampa",
          leading: getIconAsset(context, DolarBotIcons.banks.pampa),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Euro - Banco de La Pampa',
              bodyContent: CurrencyInfoScreen<EuroResponse>(
                euroEndpoint: EuroEndpoints.pampa,
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
            buildContentAndPush(
              context: context,
              title: 'Euro - Banco Nación',
              bodyContent: CurrencyInfoScreen<EuroResponse>(
                euroEndpoint: EuroEndpoints.nacion,
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
