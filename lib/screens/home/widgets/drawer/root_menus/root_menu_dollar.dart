import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/dollarResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/currency_info/currency_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuDollar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<CurrencyInfoScreenState> _key = GlobalKey();
    return MenuItem(
      text: "Dólar",
      leading: getIconData(context, FontAwesomeIcons.dollarSign),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Oficial",
          leading: getIconData(context, FontAwesomeIcons.solidCheckCircle),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Dólar Oficial',
              bodyContent: CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.oficial,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            ),
          },
        ),
        MenuItem(
          text: "Blue",
          leading: getIconData(context, FontAwesomeIcons.commentDollar),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Dólar Blue',
              bodyContent: CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.blue,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Bolsa (MEP)",
          leading: getIconData(context, FontAwesomeIcons.poll),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Dólar Bolsa (MEP)',
              bodyContent: CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.bolsa,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Contado con Liqui",
          leading: getIconData(context, FontAwesomeIcons.coins),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Dólar Contado con Liquidación',
              bodyContent: CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.contadoLiqui,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Promedio",
          leading: getIconData(context, FontAwesomeIcons.percentage),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Dólar Promedio',
              bodyContent: CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.promedio,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Bancos",
          leading: getIconData(context, FontAwesomeIcons.landmark),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: "BBVA",
              leading: getIconAsset(context, DolarBotIcons.banks.bbva),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - BBVA',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.bbva,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Chaco",
              leading: getIconAsset(context, DolarBotIcons.banks.chaco),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Nuevo Banco del Chaco',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.chaco,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Ciudad",
              leading: getIconAsset(context, DolarBotIcons.banks.ciudad),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Ciudad',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.ciudad,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Comafi",
              leading: getIconAsset(context, DolarBotIcons.banks.comafi),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Comafi',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.comafi,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Córdoba",
              leading: getIconAsset(context, DolarBotIcons.banks.cordoba),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco de Córdoba',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.bancor,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Galicia",
              leading: getIconAsset(context, DolarBotIcons.banks.galicia),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Galicia',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.galicia,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Hipotecario",
              leading: getIconAsset(context, DolarBotIcons.banks.hipotecario),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Hipotecario',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.hipotecario,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "BIND",
              leading: getIconAsset(context, DolarBotIcons.banks.bind),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Industrial (BIND)',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.bind,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "La Pampa",
              leading: getIconAsset(context, DolarBotIcons.banks.pampa),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco de La Pampa',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.pampa,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Nación",
              leading: getIconAsset(context, DolarBotIcons.banks.nacion),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Nación',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.nacion,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Patagonia",
              leading: getIconAsset(context, DolarBotIcons.banks.patagonia),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Patagonia',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.patagonia,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Piano",
              leading: getIconAsset(context, DolarBotIcons.banks.piano),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Piano',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.piano,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Santander",
              leading: getIconAsset(context, DolarBotIcons.banks.santander),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Santander',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.santander,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
            MenuItem(
              text: "Supervielle",
              leading: getIconAsset(context, DolarBotIcons.banks.supervielle),
              depthLevel: 3,
              onTap: () => {
                buildContentAndPush(
                  context: context,
                  title: 'Dólar - Banco Supervielle',
                  bodyContent: CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.supervielle,
                    key: _key,
                  ),
                  onRefresh: () => _key.currentState.refresh(),
                )
              },
            ),
          ],
        )
      ],
    );
  }
}
