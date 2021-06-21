import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/dollar_response.dart';
import 'package:dolarbot_app/api/responses/euro_response.dart';
import 'package:dolarbot_app/api/responses/real_response.dart';
import 'package:dolarbot_app/classes/app_config.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String _titleDolar = "Dólar";
const String _titleEuro = "Euro";
const String _titleReal = "Real";

class RootMenuBanks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool isProVersion = AppConfig.of(context).flavor == AppFlavor.Pro;

    return MenuItem(
      text: "Bancos",
      leading: getIconData(context, FontAwesomeIcons.landmark),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco BBVA",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.bbva,
                      colors: DolarBotConstants.kGradiantBBVA,
                      endpoint: DollarEndpoints.bbva.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco BBVA",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.bbva,
                      colors: DolarBotConstants.kGradiantBBVA,
                      endpoint: EuroEndpoints.bbva.value,
                      responseType: EuroResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleReal,
                      bannerTitle: "Banco BBVA",
                      tag: _titleReal,
                      iconAsset: DolarBotIcons.banks.bbva,
                      colors: DolarBotConstants.kGradiantBBVA,
                      endpoint: RealEndpoints.bbva.value,
                      responseType: RealResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Nuevo Banco del Chaco",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.chaco,
                      colors: DolarBotConstants.kGradiantChaco,
                      endpoint: DollarEndpoints.chaco.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Nuevo Banco del Chaco",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.chaco,
                      colors: DolarBotConstants.kGradiantChaco,
                      endpoint: EuroEndpoints.chaco.value,
                      responseType: EuroResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleReal,
                      bannerTitle: "Nuevo Banco del Chaco",
                      tag: _titleReal,
                      iconAsset: DolarBotIcons.banks.chaco,
                      colors: DolarBotConstants.kGradiantChaco,
                      endpoint: RealEndpoints.chaco.value,
                      responseType: RealResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Ciudad",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.ciudad,
                      colors: DolarBotConstants.kGradiantCiudad,
                      endpoint: DollarEndpoints.ciudad.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Ciudad",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.ciudad,
                      colors: DolarBotConstants.kGradiantCiudad,
                      endpoint: EuroEndpoints.ciudad.value,
                      responseType: EuroResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleReal,
                      bannerTitle: "Banco Ciudad",
                      tag: _titleReal,
                      iconAsset: DolarBotIcons.banks.ciudad,
                      colors: DolarBotConstants.kGradiantCiudad,
                      endpoint: RealEndpoints.ciudad.value,
                      responseType: RealResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Comafi",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.comafi,
                      colors: DolarBotConstants.kGradiantComafi,
                      endpoint: DollarEndpoints.comafi.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Comafi",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.comafi,
                      colors: DolarBotConstants.kGradiantComafi,
                      endpoint: EuroEndpoints.comafi.value,
                      responseType: EuroResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco de Córdoba",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.cordoba,
                      colors: DolarBotConstants.kGradiantCordoba,
                      endpoint: DollarEndpoints.bancor.value,
                      responseType: DollarResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Galicia",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.galicia,
                      colors: DolarBotConstants.kGradiantGalicia,
                      endpoint: DollarEndpoints.galicia.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Galicia",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.galicia,
                      colors: DolarBotConstants.kGradiantGalicia,
                      endpoint: EuroEndpoints.galicia.value,
                      responseType: EuroResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Hipotecario",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.hipotecario,
                      colors: DolarBotConstants.kGradiantHipotecario,
                      endpoint: DollarEndpoints.hipotecario.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Hipotecario",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.hipotecario,
                      colors: DolarBotConstants.kGradiantHipotecario,
                      endpoint: EuroEndpoints.hipotecario.value,
                      responseType: EuroResponse,
                    ),
                  ),
                )
              },
            ),
          ],
        ),
        MenuItem(
          text: "ICBC",
          leading: getIconAsset(context, DolarBotIcons.banks.icbc),
          depthLevel: 2,
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco ICBC",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.icbc,
                      colors: DolarBotConstants.kGradiantICBC,
                      endpoint: DollarEndpoints.icbc.value,
                      responseType: DollarResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco de La Pampa",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.pampa,
                      colors: DolarBotConstants.kGradiantPampa,
                      endpoint: DollarEndpoints.pampa.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco de La Pampa",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.pampa,
                      colors: DolarBotConstants.kGradiantPampa,
                      endpoint: EuroEndpoints.pampa.value,
                      responseType: EuroResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Nación",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.nacion,
                      colors: DolarBotConstants.kGradiantNacion,
                      endpoint: DollarEndpoints.nacion.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Nación",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.nacion,
                      colors: DolarBotConstants.kGradiantNacion,
                      endpoint: EuroEndpoints.nacion.value,
                      responseType: EuroResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleReal,
                      bannerTitle: "Banco Nación",
                      tag: _titleReal,
                      iconAsset: DolarBotIcons.banks.nacion,
                      colors: DolarBotConstants.kGradiantNacion,
                      endpoint: RealEndpoints.nacion.value,
                      responseType: RealResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Patagonia",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.patagonia,
                      colors: DolarBotConstants.kGradiantPatagonia,
                      endpoint: DollarEndpoints.patagonia.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Patagonia",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.patagonia,
                      colors: DolarBotConstants.kGradiantPatagonia,
                      endpoint: EuroEndpoints.patagonia.value,
                      responseType: EuroResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Piano",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.piano,
                      colors: DolarBotConstants.kGradiantPiano,
                      endpoint: DollarEndpoints.piano.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Piano",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.piano,
                      colors: DolarBotConstants.kGradiantPiano,
                      endpoint: EuroEndpoints.piano.value,
                      responseType: EuroResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleReal,
                      bannerTitle: "Banco Piano",
                      tag: _titleReal,
                      iconAsset: DolarBotIcons.banks.piano,
                      colors: DolarBotConstants.kGradiantPiano,
                      endpoint: RealEndpoints.piano.value,
                      responseType: RealResponse,
                    ),
                  ),
                )
              },
            ),
          ],
        ),
        MenuItem(
          text: "Provincia",
          leading: getIconAsset(context, DolarBotIcons.banks.provincia),
          depthLevel: 2,
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Provincia",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.provincia,
                      colors: DolarBotConstants.kGradiantProvincia,
                      endpoint: DollarEndpoints.provincia.value,
                      responseType: DollarResponse,
                    ),
                  ),
                )
              },
            ),
          ],
        ),
        MenuItem(
          text: "Reba",
          leading: getIconAsset(context, DolarBotIcons.banks.reba),
          depthLevel: 2,
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Rebanking",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.reba,
                      colors: DolarBotConstants.kGradiantReba,
                      endpoint: DollarEndpoints.reba.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Rebanking",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.reba,
                      colors: DolarBotConstants.kGradiantReba,
                      endpoint: EuroEndpoints.reba.value,
                      responseType: EuroResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Santander",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.santander,
                      colors: DolarBotConstants.kGradiantSantander,
                      endpoint: DollarEndpoints.santander.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Santander",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.santander,
                      colors: DolarBotConstants.kGradiantSantander,
                      endpoint: EuroEndpoints.santander.value,
                      responseType: EuroResponse,
                    ),
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
          lockedBehindProFeature: !isProVersion,
          subItems: [
            MenuItem(
              text: _titleDolar,
              leading: getIconData(context, FontAwesomeIcons.dollarSign),
              depthLevel: 3,
              onTap: () => {
                Util.navigateTo(
                  context,
                  FiatCurrencyInfoScreen<DollarResponse>(
                    cardData: CardData(
                      title: _titleDolar,
                      bannerTitle: "Banco Supervielle",
                      tag: _titleDolar,
                      iconAsset: DolarBotIcons.banks.supervielle,
                      colors: DolarBotConstants.kGradiantSupervielle,
                      endpoint: DollarEndpoints.supervielle.value,
                      responseType: DollarResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleEuro,
                      bannerTitle: "Banco Supervielle",
                      tag: _titleEuro,
                      iconAsset: DolarBotIcons.banks.supervielle,
                      colors: DolarBotConstants.kGradiantSupervielle,
                      endpoint: EuroEndpoints.supervielle.value,
                      responseType: EuroResponse,
                    ),
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
                    cardData: CardData(
                      title: _titleReal,
                      bannerTitle: "Banco Supervielle",
                      tag: _titleReal,
                      iconAsset: DolarBotIcons.banks.supervielle,
                      colors: DolarBotConstants.kGradiantSupervielle,
                      endpoint: RealEndpoints.supervielle.value,
                      responseType: RealResponse,
                    ),
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
