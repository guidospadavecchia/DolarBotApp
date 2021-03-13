import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/venezuela_info/venezuela_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuVenezuela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Venezuela';

    return MenuItem(
      text: "Venezuela",
      leading: getIconAsset(context, DolarBotIcons.general.venezuela),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "Dólar",
          leading: getIconData(context, FontAwesomeIcons.dollarSign),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              VenezuelaInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Dolar",
                  tag: "Dolar",
                  iconData: FontAwesomeIcons.dollarSign,
                  colors: DolarBotConstants.kGradiantVenezuela,
                  endpoint: VenezuelaEndpoints.dolar.value,
                  response: VenezuelaResponse,
                ),
              ),
            )
          },
        ),
        MenuItem(
          text: "Euro",
          leading: getIconData(context, FontAwesomeIcons.euroSign),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              VenezuelaInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Euro",
                  tag: "Euro",
                  iconData: FontAwesomeIcons.euroSign,
                  colors: DolarBotConstants.kGradiantVenezuela,
                  endpoint: VenezuelaEndpoints.euro.value,
                  response: VenezuelaResponse,
                ),
              ),
            )
          },
        ),
      ],
    );
  }
}
