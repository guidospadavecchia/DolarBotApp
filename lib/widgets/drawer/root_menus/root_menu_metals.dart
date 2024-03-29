import '../../../api/api_endpoints.dart';
import '../../../api/responses/metal_response.dart';
import '../../../util/constants.dart';
import '../../../classes/dolarbot_icons.dart';
import '../drawer_menu_body.dart';
import '../../../screens/metal_info/metal_info_screen.dart';
import '../../cards/factory/card_data.dart';
import '../../common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const String _title = 'Metal';

class RootMenuMetals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Oro",
                  tag: _title,
                  iconAsset: DolarBotIcons.metals.gold,
                  colors: DolarBotConstants.kGradiantGold,
                  endpoint: MetalEndpoints.oro.value,
                  responseType: MetalResponse,
                ),
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Plata",
                  tag: _title,
                  iconAsset: DolarBotIcons.metals.silver,
                  colors: DolarBotConstants.kGradiantSilver,
                  endpoint: MetalEndpoints.plata.value,
                  responseType: MetalResponse,
                ),
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
                cardData: CardData(
                  title: _title,
                  bannerTitle: "Cobre",
                  tag: _title,
                  iconAsset: DolarBotIcons.metals.copper,
                  colors: DolarBotConstants.kGradiantCopper,
                  endpoint: MetalEndpoints.cobre.value,
                  responseType: MetalResponse,
                ),
              ),
            )
          },
        ),
      ],
    );
  }
}
