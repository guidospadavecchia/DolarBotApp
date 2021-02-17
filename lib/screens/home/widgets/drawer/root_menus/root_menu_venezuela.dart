import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/venezuela_info/venezuela_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuVenezuela extends StatelessWidget {
  final Function onRefresh;

  const RootMenuVenezuela({
    Key key,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  key: key,
                ),
                onRefresh: onRefresh)
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
                  key: key,
                ),
                onRefresh: onRefresh)
          },
        ),
      ],
    );
  }
}
