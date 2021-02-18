import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/metal_info/metal_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuMetals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<MetalInfoScreenState> _key = GlobalKey();
    return MenuItem(
      text: "Metales",
      leading: getIconData(context, FontAwesomeIcons.sketch),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Oro",
          leading: getIconAsset(context, DolarBotIcons.metals.gold),
          depthLevel: 2,
          onTap: () {
            buildContentAndPush(
              context: context,
              title: 'Oro',
              bodyContent: MetalInfoScreen(
                metalEndpoint: MetalEndpoints.oro,
              ),
              onRefresh: () => _key.currentState.refresh(),
            );
          },
        ),
        MenuItem(
          text: "Plata",
          leading: getIconAsset(context, DolarBotIcons.metals.silver),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Plata',
              bodyContent: MetalInfoScreen(
                metalEndpoint: MetalEndpoints.plata,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
        MenuItem(
          text: "Cobre",
          leading: getIconAsset(context, DolarBotIcons.metals.copper),
          depthLevel: 2,
          onTap: () => {
            buildContentAndPush(
              context: context,
              title: 'Cobre',
              bodyContent: MetalInfoScreen(
                metalEndpoint: MetalEndpoints.cobre,
              ),
              onRefresh: () => _key.currentState.refresh(),
            )
          },
        ),
      ],
    );
  }
}
