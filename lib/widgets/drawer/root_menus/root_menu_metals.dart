import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/metal_info/metal_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/card_data.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RootMenuMetals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Metal';

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
            Util.navigateTo(
              context,
              MetalInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Oro",
                  tag: _title,
                  iconAsset: DolarBotIcons.metals.gold,
                  colors: DolarBotConstants.kGradiantGold,
                  endpoint: MetalEndpoints.oro.value,
                  response: MetalResponse,
                ),
                //metalEndpoint: MetalEndpoints.oro,
              ),
            )
          },
        ),
        MenuItem(
          text: "Plata",
          leading: getIconAsset(context, DolarBotIcons.metals.silver),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              MetalInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Plata",
                  tag: _title,
                  iconAsset: DolarBotIcons.metals.silver,
                  colors: DolarBotConstants.kGradiantSilver,
                  endpoint: MetalEndpoints.plata.value,
                  response: MetalResponse,
                ),
                //metalEndpoint: MetalEndpoints.plata,
              ),
            )
          },
        ),
        MenuItem(
          text: "Cobre",
          leading: getIconAsset(context, DolarBotIcons.metals.copper),
          depthLevel: 2,
          onTap: () => {
            Util.navigateTo(
              context,
              MetalInfoScreen(
                title: _title,
                cardData: CardData(
                  title: "Cobre",
                  tag: _title,
                  iconAsset: DolarBotIcons.metals.copper,
                  colors: DolarBotConstants.kGradiantCopper,
                  endpoint: MetalEndpoints.cobre.value,
                  response: MetalResponse,
                ),
                //metalEndpoint: MetalEndpoints.cobre,
              ),
            )
          },
        ),
      ],
    );
  }
}