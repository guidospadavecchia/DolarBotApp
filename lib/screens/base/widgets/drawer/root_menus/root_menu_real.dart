import 'package:dolarbot_app/api/api_endpoints.dart';
import 'package:dolarbot_app/api/responses/realResponse.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu_body.dart';
import 'package:dolarbot_app/screens/fiat_currency_info/fiat_currency_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';

class RootMenuReal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = 'Real';

    return MenuItem(
      text: "Real",
      leading: getIconAsset(context, DolarBotIcons.general.real),
      depthLevel: 1,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: _title,
                bannerIconAsset: DolarBotIcons.banks.bbva,
                bannerTitle: "Banco BBVA",
                gradiantColors: DolarBotConstants.kGradiantBBVA,
                realEndpoint: RealEndpoints.bbva,
              ),
            )
          },
        ),
        MenuItem(
          text: "Chaco",
          leading: getIconAsset(context, DolarBotIcons.banks.chaco),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: _title,
                bannerIconAsset: DolarBotIcons.banks.chaco,
                bannerTitle: "Nuevo Banco del Chaco",
                gradiantColors: DolarBotConstants.kGradiantChaco,
                realEndpoint: RealEndpoints.chaco,
              ),
            )
          },
        ),
        MenuItem(
          text: "Nación",
          leading: getIconAsset(context, DolarBotIcons.banks.nacion),
          depthLevel: 2,
          onTap: () => {
            navigateTo(
              context,
              FiatCurrencyInfoScreen<RealResponse>(
                title: _title,
                bannerIconAsset: DolarBotIcons.banks.nacion,
                bannerTitle: "Banco Nación",
                gradiantColors: DolarBotConstants.kGradiantNacion,
                realEndpoint: RealEndpoints.nacion,
              ),
            )
          },
        ),
      ],
    );
  }
}
