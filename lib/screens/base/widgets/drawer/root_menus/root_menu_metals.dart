import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/classes/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/metal_info/metal_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuMetals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Metales';

    return MenuItem(
      text: "Metales",
      leading: getIconData(context, FontAwesomeIcons.sketch),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "Oro",
          leading: getIconAsset(context, DolarBotIcons.metals.gold),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              MetalInfoScreen(
                title: _title,
                bannerIconAsset: DolarBotIcons.metals.gold,
                bannerTitle: "Oro",
                gradiantColors: DolarBotConstants.kGradiantGold,
                metalEndpoint: MetalEndpoints.oro,
              ),
            )
          },
        ),
        MenuItem(
          text: "Plata",
          leading: getIconAsset(context, DolarBotIcons.metals.silver),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              MetalInfoScreen(
                title: _title,
                bannerIconAsset: DolarBotIcons.metals.silver,
                bannerTitle: "Plata",
                gradiantColors: DolarBotConstants.kGradiantSilver,
                metalEndpoint: MetalEndpoints.plata,
              ),
            )
          },
        ),
        MenuItem(
          text: "Cobre",
          leading: getIconAsset(context, DolarBotIcons.metals.copper),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              MetalInfoScreen(
                title: _title,
                bannerIconAsset: DolarBotIcons.metals.copper,
                bannerTitle: "Cobre",
                gradiantColors: DolarBotConstants.kGradiantCopper,
                metalEndpoint: MetalEndpoints.cobre,
              ),
            )
          },
        ),
      ],
    );
  }
}
