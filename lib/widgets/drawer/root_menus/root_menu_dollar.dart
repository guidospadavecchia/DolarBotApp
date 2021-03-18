import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/dollar_response.dart';
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
      ],
    );
  }
}
