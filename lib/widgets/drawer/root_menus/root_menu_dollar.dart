import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/dollar_response.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: _title,
                cardData: CardData(
                  title: "Oficial",
                  tag: _title,
                  iconData: FontAwesomeIcons.dollarSign,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.oficial.value,
                  response: DollarResponse,
                ),
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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: _title,
                cardData: CardData(
                  title: "Ahorro",
                  tag: _title,
                  iconData: FontAwesomeIcons.piggyBank,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.ahorro.value,
                  response: DollarResponse,
                ),
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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: _title,
                cardData: CardData(
                  title: "Blue",
                  tag: _title,
                  iconData: FontAwesomeIcons.commentDollar,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.blue.value,
                  response: DollarResponse,
                ),
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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: _title,
                cardData: CardData(
                  title: "Bolsa (MEP)",
                  tag: _title,
                  iconData: FontAwesomeIcons.poll,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.bolsa.value,
                  response: DollarResponse,
                ),
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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: _title,
                cardData: CardData(
                  title: "Contado con Liqui",
                  tag: _title,
                  iconData: FontAwesomeIcons.coins,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.contadoLiqui.value,
                  response: DollarResponse,
                ),
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
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                title: _title,
                cardData: CardData(
                  title: "Promedio",
                  tag: _title,
                  iconData: FontAwesomeIcons.percentage,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.promedio.value,
                  response: DollarResponse,
                ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco BBVA",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.bbva,
                      colors: DolarBotConstants.kGradiantBBVA,
                      endpoint: DollarEndpoints.bbva.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Nuevo Banco del Chaco",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.chaco,
                      colors: DolarBotConstants.kGradiantChaco,
                      endpoint: DollarEndpoints.chaco.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Ciudad",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.ciudad,
                      colors: DolarBotConstants.kGradiantCiudad,
                      endpoint: DollarEndpoints.ciudad.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Comafi",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.comafi,
                      colors: DolarBotConstants.kGradiantComafi,
                      endpoint: DollarEndpoints.comafi.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco de Córdoba",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.cordoba,
                      colors: DolarBotConstants.kGradiantCordoba,
                      endpoint: DollarEndpoints.bancor.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Galicia",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.galicia,
                      colors: DolarBotConstants.kGradiantGalicia,
                      endpoint: DollarEndpoints.galicia.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Hipotecario",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.hipotecario,
                      colors: DolarBotConstants.kGradiantHipotecario,
                      endpoint: DollarEndpoints.hipotecario.value,
                      response: DollarResponse,
                    ),
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
            //     Util.navigateTo(
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco de La Pampa",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.pampa,
                      colors: DolarBotConstants.kGradiantPampa,
                      endpoint: DollarEndpoints.pampa.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Nación",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.nacion,
                      colors: DolarBotConstants.kGradiantNacion,
                      endpoint: DollarEndpoints.nacion.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Patagonia",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.patagonia,
                      colors: DolarBotConstants.kGradiantPatagonia,
                      endpoint: DollarEndpoints.patagonia.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Piano",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.piano,
                      colors: DolarBotConstants.kGradiantPiano,
                      endpoint: DollarEndpoints.piano.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Santander",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.santander,
                      colors: DolarBotConstants.kGradiantSantander,
                      endpoint: DollarEndpoints.santander.value,
                      response: DollarResponse,
                    ),
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
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _title,
                    cardData: CardData(
                      title: "Banco Supervielle",
                      tag: _title,
                      iconAsset: DolarBotIcons.banks.supervielle,
                      colors: DolarBotConstants.kGradiantSupervielle,
                      endpoint: DollarEndpoints.supervielle.value,
                      response: DollarResponse,
                    ),
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
