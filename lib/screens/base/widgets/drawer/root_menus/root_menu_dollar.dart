import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/dollarResponse.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuDollar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Dólar';

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
                title: "Dólar",
                bannerIconData: FontAwesomeIcons.dollarSign,
                bannerTitle: "Oficial",
                gradiantColors: DolarBotConstants.kGradiantDefault,
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
                title: "Dólar",
                bannerIconData: FontAwesomeIcons.piggyBank,
                bannerTitle: "Ahorro",
                gradiantColors: DolarBotConstants.kGradiantDefault,
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
                title: "Dólar",
                bannerIconData: FontAwesomeIcons.commentDollar,
                bannerTitle: "Blue",
                gradiantColors: DolarBotConstants.kGradiantDefault,
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
                title: "Dólar",
                bannerIconData: FontAwesomeIcons.poll,
                bannerTitle: "Bolsa (MEP)",
                gradiantColors: DolarBotConstants.kGradiantDefault,
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
                title: 'Dólar',
                bannerIconData: FontAwesomeIcons.coins,
                bannerTitle: "Contado con Liqui",
                gradiantColors: DolarBotConstants.kGradiantDefault,
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
                title: 'Dólar',
                bannerIconData: FontAwesomeIcons.percentage,
                bannerTitle: "Promedio",
                gradiantColors: DolarBotConstants.kGradiantDefault,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.bbva,
                    bannerTitle: "Banco BBVA",
                    gradiantColors: DolarBotConstants.kGradiantBBVA,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.chaco,
                    bannerTitle: "Nuevo Banco del Chaco",
                    gradiantColors: DolarBotConstants.kGradiantChaco,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.ciudad,
                    bannerTitle: "Banco Ciudad",
                    gradiantColors: DolarBotConstants.kGradiantCiudad,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.comafi,
                    bannerTitle: "Banco Comafi",
                    gradiantColors: DolarBotConstants.kGradiantComafi,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.cordoba,
                    bannerTitle: "Banco de Córdoba",
                    gradiantColors: DolarBotConstants.kGradiantCordoba,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.galicia,
                    bannerTitle: "Banco Galicia",
                    gradiantColors: DolarBotConstants.kGradiantGalicia,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.hipotecario,
                    bannerTitle: "Banco Hipotecario",
                    gradiantColors: DolarBotConstants.kGradiantHipotecario,
                    dollarEndpoint: DollarEndpoints.hipotecario,
                  ),
                )
              },
            ),
            // MenuItem(
            //   text: "BIND",
            //   leading: getIconAsset(context, DolarBotIcons.banks.bind),
            //   depthLevel: 3,
            //   onTap: () => {
            //     navigateTo(
            //       context,
            //       FiatCurrencyInfoScreen<DollarResponse>(
            //         title: _title,
            //         bannerIconAsset: DolarBotIcons.banks.bind,
            //         bannerTitle: "Banco Industrial",
            //         gradiantColors: DolarBotConstants.kGradiantIndustrial,
            //         dollarEndpoint: DollarEndpoints.bind,
            //       ),
            //     )
            //   },
            // ),
            MenuItem(
              text: "La Pampa",
              leading: getIconAsset(context, DolarBotIcons.banks.pampa),
              depthLevel: 3,
              onTap: () => {
                navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.pampa,
                    bannerTitle: "Banco de La Pampa",
                    gradiantColors: DolarBotConstants.kGradiantPampa,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.nacion,
                    bannerTitle: "Banco Nación",
                    gradiantColors: DolarBotConstants.kGradiantNacion,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.patagonia,
                    bannerTitle: "Banco Patagonia",
                    gradiantColors: DolarBotConstants.kGradiantPatagonia,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.piano,
                    bannerTitle: "Banco Piano",
                    gradiantColors: DolarBotConstants.kGradiantPiano,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.santander,
                    bannerTitle: "Banco Santander",
                    gradiantColors: DolarBotConstants.kGradiantSantander,
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
                    title: _title,
                    bannerIconAsset: DolarBotIcons.banks.supervielle,
                    bannerTitle: "Banco Supervielle",
                    gradiantColors: DolarBotConstants.kGradiantSupervielle,
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
