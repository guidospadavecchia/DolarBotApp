import '../../../api/api_endpoints.dart';
import '../../../api/responses/base/api_response.dart';
import '../../../util/constants.dart';
import '../../../classes/dolarbot_icons.dart';
import '../drawer_menu_body.dart';
import '../../../screens/venezuela_info/venezuela_info_screen.dart';
import '../../cards/factory/card_data.dart';
import '../../common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String _title = 'Venezuela';

class RootMenuVenezuela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Dólar",
                  tag: "Dólar",
                  iconData: FontAwesomeIcons.dollarSign,
                  colors: DolarBotConstants.kGradiantVenezuela,
                  endpoint: VenezuelaEndpoints.dolar.value,
                  responseType: VenezuelaResponse,
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Euro",
                  tag: "Euro",
                  iconData: FontAwesomeIcons.euroSign,
                  colors: DolarBotConstants.kGradiantVenezuela,
                  endpoint: VenezuelaEndpoints.euro.value,
                  responseType: VenezuelaResponse,
                ),
              ),
            )
          },
        ),
      ],
    );
  }
}
