import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/dollarResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuDollar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuItem(
      text: "Dólar",
      leading: getIconData(context, FontAwesomeIcons.dollarSign),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "Oficial",
          leading: getIconData(context, FontAwesomeIcons.solidCheckCircle),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: "Dolar Oficial",
                dollarEndpoint: DollarEndpoints.oficial,
              ),
            )
          },
        ),
        MenuItem(
          text: "Ahorro",
          leading: getIconData(context, FontAwesomeIcons.piggyBank),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: "Dolar Ahorro",
                dollarEndpoint: DollarEndpoints.ahorro,
              ),
            )
          },
        ),
        MenuItem(
          text: "Blue",
          leading: getIconData(context, FontAwesomeIcons.commentDollar),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: "Dolar Blue",
                dollarEndpoint: DollarEndpoints.blue,
              ),
            )
          },
        ),
        MenuItem(
          text: "Bolsa (MEP)",
          leading: getIconData(context, FontAwesomeIcons.poll),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: "Dolar Bolsa (MEP)",
                dollarEndpoint: DollarEndpoints.bolsa,
              ),
            )
          },
        ),
        MenuItem(
          text: "Contado con Liqui",
          leading: getIconData(context, FontAwesomeIcons.coins),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: 'Dólar Contado con Liqui',
                dollarEndpoint: DollarEndpoints.contadoLiqui,
              ),
            )
          },
        ),
        MenuItem(
          text: "Promedio",
          leading: getIconData(context, FontAwesomeIcons.percentage),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: 'Dólar Promedio',
                dollarEndpoint: DollarEndpoints.promedio,
              ),
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
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - BBVA',
                    dollarEndpoint: DollarEndpoints.bbva,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Chaco",
              leading: getIconAsset(context, DolarBotIcons.banks.chaco),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Nuevo Banco del Chaco',
                    dollarEndpoint: DollarEndpoints.chaco,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Ciudad",
              leading: getIconAsset(context, DolarBotIcons.banks.ciudad),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Ciudad',
                    dollarEndpoint: DollarEndpoints.ciudad,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Comafi",
              leading: getIconAsset(context, DolarBotIcons.banks.comafi),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Comafi',
                    dollarEndpoint: DollarEndpoints.comafi,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Córdoba",
              leading: getIconAsset(context, DolarBotIcons.banks.cordoba),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco de Córdoba',
                    dollarEndpoint: DollarEndpoints.bancor,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Galicia",
              leading: getIconAsset(context, DolarBotIcons.banks.galicia),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Galicia',
                    dollarEndpoint: DollarEndpoints.galicia,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Hipotecario",
              leading: getIconAsset(context, DolarBotIcons.banks.hipotecario),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Hipotecario',
                    dollarEndpoint: DollarEndpoints.hipotecario,
                  ),
                )
              },
            ),
            MenuItem(
              text: "BIND",
              leading: getIconAsset(context, DolarBotIcons.banks.bind),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Industrial (BIND)',
                    dollarEndpoint: DollarEndpoints.bind,
                  ),
                )
              },
            ),
            MenuItem(
              text: "La Pampa",
              leading: getIconAsset(context, DolarBotIcons.banks.pampa),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco de La Pampa',
                    dollarEndpoint: DollarEndpoints.pampa,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Nación",
              leading: getIconAsset(context, DolarBotIcons.banks.nacion),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Nación',
                    dollarEndpoint: DollarEndpoints.nacion,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Patagonia",
              leading: getIconAsset(context, DolarBotIcons.banks.patagonia),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Patagonia',
                    dollarEndpoint: DollarEndpoints.patagonia,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Piano",
              leading: getIconAsset(context, DolarBotIcons.banks.piano),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Piano',
                    dollarEndpoint: DollarEndpoints.piano,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Santander",
              leading: getIconAsset(context, DolarBotIcons.banks.santander),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Santander',
                    dollarEndpoint: DollarEndpoints.santander,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Supervielle",
              leading: getIconAsset(context, DolarBotIcons.banks.supervielle),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: 'Dólar - Banco Supervielle',
                    dollarEndpoint: DollarEndpoints.supervielle,
                  ),
                )
              },
            ),
          ],
        )
      ],
    );
  }
}
