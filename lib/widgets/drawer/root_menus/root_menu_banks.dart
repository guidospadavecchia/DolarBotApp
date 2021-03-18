import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/dollar_response.dart';
import 'package:dolarbot_app/api/responses/euro_response.dart';
import 'package:dolarbot_app/api/responses/real_response.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuBanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _titleDolar = 'Dólar';
    const String _titleEuro = 'Euro';
    const String _titleReal = 'Real';

    return MenuItem(
      text: "Bancos",
      leading: getIconData(context, FontAwesomeIcons.landmark),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco BBVA",
                      tag: _titleDolar,
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
              text: _titleEuro,
              leading: getIconData(context, FontAwesomeIcons.euroSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<EuroResponse>(
                    title: _titleEuro,
                    cardData: CardData(
                      title: "Banco BBVA",
                      tag: _titleEuro,
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
              text: _titleReal,
              leading: getIconAsset(context, DolarBotIcons.general.real),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<RealResponse>(
                    title: _titleReal,
                    cardData: CardData(
                      title: "Banco BBVA",
                      tag: _titleReal,
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
          ],
        ),
        MenuItem(
          text: "Chaco",
          leading: getIconAsset(context, DolarBotIcons.banks.chaco),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Nuevo Banco del Chaco",
                      tag: _titleDolar,
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
              text: _titleEuro,
              leading: getIconData(context, FontAwesomeIcons.euroSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<EuroResponse>(
                    title: _titleEuro,
                    cardData: CardData(
                      title: "Nuevo Banco del Chaco",
                      tag: _titleEuro,
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
              text: _titleReal,
              leading: getIconAsset(context, DolarBotIcons.general.real),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<RealResponse>(
                    title: _titleReal,
                    cardData: CardData(
                      title: "Nuevo Banco del Chaco",
                      tag: _titleReal,
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
          ],
        ),
        MenuItem(
          text: "Ciudad",
          leading: getIconAsset(context, DolarBotIcons.banks.ciudad),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Ciudad",
                      tag: _titleDolar,
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
          ],
        ),
        MenuItem(
          text: "Comafi",
          leading: getIconAsset(context, DolarBotIcons.banks.comafi),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Comafi",
                      tag: _titleDolar,
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
          ],
        ),
        MenuItem(
          text: "Córdoba",
          leading: getIconAsset(context, DolarBotIcons.banks.cordoba),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco de Córdoba",
                      tag: _titleDolar,
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
          ],
        ),
        MenuItem(
          text: "Galicia",
          leading: getIconAsset(context, DolarBotIcons.banks.galicia),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Galicia",
                      tag: _titleDolar,
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
              text: _titleEuro,
              leading: getIconData(context, FontAwesomeIcons.euroSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<EuroResponse>(
                    title: _titleEuro,
                    cardData: CardData(
                      title: "Banco Galicia",
                      tag: _titleEuro,
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
          ],
        ),
        MenuItem(
          text: "Hipotecario",
          leading: getIconAsset(context, DolarBotIcons.banks.hipotecario),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Hipotecario",
                      tag: _titleDolar,
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
            MenuItem(
              text: _titleEuro,
              leading: getIconData(context, FontAwesomeIcons.euroSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<EuroResponse>(
                    title: _titleEuro,
                    cardData: CardData(
                      title: "Banco Hipotecario",
                      tag: _titleEuro,
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
          ],
        ),
        MenuItem(
          text: "La Pampa",
          leading: getIconAsset(context, DolarBotIcons.banks.pampa),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco de La Pampa",
                      tag: _titleDolar,
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
              text: _titleEuro,
              leading: getIconData(context, FontAwesomeIcons.euroSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<EuroResponse>(
                    title: _titleEuro,
                    cardData: CardData(
                      title: "Banco de La Pampa",
                      tag: _titleEuro,
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
          ],
        ),
        MenuItem(
          text: "Nación",
          leading: getIconAsset(context, DolarBotIcons.banks.nacion),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Nación",
                      tag: _titleDolar,
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
              text: _titleEuro,
              leading: getIconData(context, FontAwesomeIcons.euroSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<EuroResponse>(
                    title: _titleEuro,
                    cardData: CardData(
                      title: "Banco Nación",
                      tag: _titleEuro,
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
            MenuItem(
              text: _titleReal,
              leading: getIconAsset(context, DolarBotIcons.general.real),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<RealResponse>(
                    title: _titleReal,
                    cardData: CardData(
                      title: "Banco Nación",
                      tag: _titleReal,
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
        ),
        MenuItem(
          text: "Patagonia",
          leading: getIconAsset(context, DolarBotIcons.banks.patagonia),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Patagonia",
                      tag: _titleDolar,
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
          ],
        ),
        MenuItem(
          text: "Piano",
          leading: getIconAsset(context, DolarBotIcons.banks.piano),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Piano",
                      tag: _titleDolar,
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
          ],
        ),
        MenuItem(
          text: "Santander",
          leading: getIconAsset(context, DolarBotIcons.banks.santander),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Santander",
                      tag: _titleDolar,
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
          ],
        ),
        MenuItem(
          text: "Supervielle",
          leading: getIconAsset(context, DolarBotIcons.banks.supervielle),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    title: _titleDolar,
                    cardData: CardData(
                      title: "Banco Supervielle",
                      tag: _titleDolar,
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
        ),
      ],
    );
  }
}
