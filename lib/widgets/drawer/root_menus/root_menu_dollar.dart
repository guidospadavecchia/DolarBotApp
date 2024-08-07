import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../api/api_endpoints.dart';
import '../../../api/responses/dollar_response.dart';
import '../../../screens/fiat_currency_info/fiat_currency_info_screen.dart';
import '../../../util/constants.dart';
import '../../cards/factory/card_data.dart';
import '../../common/menu_item.dart';
import '../drawer_menu_body.dart';

const String _title = 'Dólar';

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
          leading: getIconData(context, FontAwesomeIcons.solidCircleCheck),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Oficial",
                  tag: _title,
                  iconData: FontAwesomeIcons.dollarSign,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.oficial.value,
                  responseType: DollarResponse,
                ),
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Ahorro",
                  tag: _title,
                  iconData: FontAwesomeIcons.piggyBank,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.ahorro.value,
                  responseType: DollarResponse,
                ),
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Blue",
                  tag: _title,
                  iconData: FontAwesomeIcons.commentDollar,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.blue.value,
                  responseType: DollarResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "MEP (Bolsa)",
          leading: getIconData(context, FontAwesomeIcons.squarePollVertical),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "MEP (Bolsa)",
                  tag: _title,
                  iconData: FontAwesomeIcons.squarePollVertical,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.bolsa.value,
                  responseType: DollarResponse,
                ),
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Contado con Liqui",
                  tag: _title,
                  iconData: FontAwesomeIcons.coins,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.contadoLiqui.value,
                  responseType: DollarResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Promedio",
          leading: getIconData(context, FontAwesomeIcons.percent),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<DollarResponse>(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Promedio",
                  tag: _title,
                  iconData: FontAwesomeIcons.percent,
                  colors: DolarBotConstants.kGradiantDefault,
                  endpoint: DollarEndpoints.promedio.value,
                  responseType: DollarResponse,
                ),
              ),
            )
          },
        ),
      ],
    );
  }
}
