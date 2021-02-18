import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/venezuela_info/venezuela_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuVenezuela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<VenezuelaInfoScreenState> _key = GlobalKey();

    return MenuItem(
      text: "Venezuela",
      leading: getIconAsset(context, DolarBotIcons.general.venezuela),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Dólar",
          leading: getIconData(context, FontAwesomeIcons.dollarSign),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context: context,
              title: 'Dólar (Venezuela)',
              bodyContent: VenezuelaInfoScreen(
                vzlaEndpoint: VenezuelaEndpoints.dolar,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Euro",
          leading: getIconData(context, FontAwesomeIcons.euroSign),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context: context,
              title: 'Euro (Venezuela)',
              bodyContent: VenezuelaInfoScreen(
                vzlaEndpoint: VenezuelaEndpoints.euro,
                key: _key,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
      ],
    );
  }
}
