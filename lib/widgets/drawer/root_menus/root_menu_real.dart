import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String _title = 'Real';

class RootMenuReal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuItem(
      text: _title,
      leading: getIconAsset(context, DolarBotIcons.general.real),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "Oficial",
          leading: getIconData(context, FontAwesomeIcons.solidCheckCircle),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Oficial",
                  tag: _title,
                  iconAsset: DolarBotIcons.general.real,
                  colors: DolarBotConstants.kGradiantReal,
                  endpoint: RealEndpoints.oficial.value,
                  responseType: RealResponse,
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
              FiatCurrencyInfoScreen<RealResponse>(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Ahorro",
                  tag: _title,
                  iconData: FontAwesomeIcons.piggyBank,
                  colors: DolarBotConstants.kGradiantReal,
                  endpoint: RealEndpoints.ahorro.value,
                  responseType: RealResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Blue",
          leading: getIconAsset(context, DolarBotIcons.general.realBlue),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Blue",
                  tag: _title,
                  iconAsset: DolarBotIcons.general.realBlue,
                  colors: DolarBotConstants.kGradiantReal,
                  endpoint: RealEndpoints.blue.value,
                  responseType: RealResponse,
                ),
              ),
            )
          },
        ),
      ],
    );
  }
}
