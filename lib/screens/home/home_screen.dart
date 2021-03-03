import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_value.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseInfoScreen {
  HomeScreen({
    Key key,
  }) : super(key: key, title: "Inicio");

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseInfoScreenState<HomeScreen> with BaseScreen {
  @override
  showRefreshButton() => false;

  @override
  bool showFabMenu() => false;

  @override
  bool extendBodyBehindAppBar() => false;

  @override
  CardFavorite card() => null;

  @override
  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: Consumer<Settings>(builder: (context, settings, child) {
          return Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 110),
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  CardFavorite(
                    showPoweredBy: false,
                    header: CardHeader(title: "Banco Patagonia"),
                    spaceBetweenItems: Spacing.medium,
                    rates: [
                      CardValue(
                        title: "Compra",
                        value: "190.50",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Venta",
                        value: "195.50",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Ahorro",
                        value: "157.57",
                        symbol: "\$",
                      ),
                    ],
                    logo: CardLogo(
                      iconAsset: DolarBotIcons.banks.patagonia,
                      tag: "Dolar",
                    ),
                    lastUpdated: CardLastUpdated(
                      timestamp: "27/02/2021 - 19:36",
                    ),
                    gradiantColors: DolarBotConstants.kGradiantPatagonia,
                  ),
                  CardFavorite(
                    header: CardHeader(title: "Banco BBVA"),
                    spaceBetweenItems: Spacing.small,
                    rates: [
                      CardValue(
                        title: "Compra",
                        value: "107.85",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Venta",
                        value: "114.85",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Ahorro",
                        value: "189.50",
                        symbol: "\$",
                      ),
                    ],
                    logo: CardLogo(
                      iconAsset: DolarBotIcons.banks.bbva,
                      tag: "Euro",
                    ),
                    lastUpdated: CardLastUpdated(
                      timestamp: "27/02/2021 - 19:36",
                    ),
                    gradiantColors: DolarBotConstants.kGradiantBBVA,
                  ),
                  CardFavorite(
                    header: CardHeader(title: "Banco Nación"),
                    spaceBetweenItems: Spacing.large,
                    rates: [
                      CardValue(
                        title: "Compra",
                        value: "15.70",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Venta",
                        value: "17.70",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Ahorro",
                        value: "29.20",
                        symbol: "\$",
                      ),
                    ],
                    logo: CardLogo(
                      iconAsset: DolarBotIcons.banks.nacion,
                      tag: "Real",
                    ),
                    lastUpdated: CardLastUpdated(
                      timestamp: "27/02/2021 - 19:36",
                    ),
                    gradiantColors: DolarBotConstants.kGradiantNacion,
                  ),
                  CardFavorite(
                    height: 270,
                    header: CardHeader(title: "Ethereum"),
                    spaceBetweenItems: Spacing.large,
                    direction: Axis.vertical,
                    rates: [
                      CardValue(
                        title: "Pesos Args.",
                        value: "131461.00",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Pesos Args. + Imp.",
                        value: "216910.65",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Dólares Estadounidenses",
                        value: "1463.05",
                        symbol: "US\$",
                      ),
                    ],
                    logo: CardLogo(
                      iconData: CryptoFontIcons.ETH,
                      tag: "Crypto",
                    ),
                    lastUpdated: CardLastUpdated(
                      timestamp: "27/02/2021 - 19:36",
                    ),
                    gradiantColors: DolarBotConstants.kGradiantEthereum,
                  ),
                  CardFavorite(
                    height: 270,
                    header: CardHeader(title: "Bitcoin"),
                    spaceBetweenItems: Spacing.large,
                    rates: [
                      CardValue(
                        title: "Pesos Args.",
                        value: "4042042.00",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Pesos Args. + Imp.",
                        value: "6669374.65",
                        symbol: "\$",
                      ),
                      CardValue(
                        title: "Dólares Estadounidenses",
                        value: "44985.00",
                        symbol: "US\$",
                      ),
                    ],
                    logo: CardLogo(
                      iconData: CryptoFontIcons.BTC,
                      tag: "Crypto",
                    ),
                    lastUpdated: CardLastUpdated(
                      timestamp: "27/02/2021 - 19:36",
                    ),
                    gradiantColors: DolarBotConstants.kGradiantBitcoin,
                  ),
                  CardFavorite(
                    height: 150,
                    header: CardHeader(title: "Oro"),
                    spaceBetweenHeader: Spacing.small,
                    rates: [
                      CardValue(
                        title: "/ Onza",
                        value: "1718.02",
                        symbol: "US\$",
                        direction: Axis.horizontal,
                        textDirection: TextDirection.rtl,
                        spaceBetweenTitle: Spacing.small,
                        crossAlignment: WrapCrossAlignment.center,
                        valueSize: 32,
                      ),
                    ],
                    logo: CardLogo(
                      iconAsset: DolarBotIcons.metals.gold,
                      tag: "METAL",
                    ),
                    lastUpdated: CardLastUpdated(
                      timestamp: "27/02/2021 - 19:36",
                    ),
                    gradiantColors: DolarBotConstants.kGradiantGold,
                  ),
                  // CardFavorite(
                  //   height: 100,
                  //   header: CardHeader(title: "Plata"),
                  //   spaceBetweenHeader: Spacing.small,
                  //   rates: [
                  //     CardValue(
                  //       title: "/ Onza",
                  //       value: "26.28",
                  //       symbol: "US\$",
                  //       direction: Axis.horizontal,
                  //       textDirection: TextDirection.rtl,
                  //       spaceBetweenTitle: Spacing.small,
                  //       crossAlignment: WrapCrossAlignment.center,
                  //       valueSize: 32,
                  //     ),
                  //   ],
                  //   logo: CardLogo(
                  //     iconAsset: DolarBotIcons.metals.silver,
                  //     tag: "METAL",
                  //   ),
                  //   lastUpdated: CardLastUpdated(
                  //     timestamp: "27/02/2021 - 19:36",
                  //   ),
                  //   gradiantColors: DolarBotConstants.kGradiantSilver,
                  // ),
                  // CardFavorite(
                  //   height: 100,
                  //   header: CardHeader(title: "Cobre"),
                  //   spaceBetweenHeader: Spacing.small,
                  //   rates: [
                  //     CardValue(
                  //       title: "/ Onza",
                  //       value: "9614.50",
                  //       symbol: "US\$",
                  //       direction: Axis.horizontal,
                  //       textDirection: TextDirection.rtl,
                  //       spaceBetweenTitle: Spacing.medium,
                  //       crossAlignment: WrapCrossAlignment.center,
                  //       valueSize: 32,
                  //     ),
                  //   ],
                  //   logo: CardLogo(
                  //     iconAsset: DolarBotIcons.metals.copper,
                  //     tag: "METAL",
                  //   ),
                  //   lastUpdated: CardLastUpdated(
                  //     timestamp: "27/02/2021 - 19:36",
                  //   ),
                  //   gradiantColors: DolarBotConstants.kGradiantCopper,
                  // ),
                  CardFavorite(
                    height: 210,
                    header: CardHeader(title: "Venezuela"),
                    rates: [
                      CardValue(
                        title: "Promedio Bancos",
                        value: "1871361.13",
                        symbol: "\Bs.",
                        spaceMainAxisEnd: Spacing.large,
                        titleSize: 16,
                        valueSize: 20,
                      ),
                      CardValue(
                        title: "Paralelo",
                        value: "1899023.81",
                        symbol: "\Bs.",
                        spaceMainAxisEnd: Spacing.none,
                        titleSize: 16,
                        valueSize: 20,
                      ),
                    ],
                    logo: CardLogo(
                      iconAsset: DolarBotIcons.general.venezuela,
                      tag: "Dolar",
                    ),
                    lastUpdated: CardLastUpdated(
                      timestamp: "27/02/2021 - 19:36",
                    ),
                    gradiantColors: DolarBotConstants.kGradiantVenezuela,
                  ),
                  // CardBank(
                  //   header: CardHeader(title: "Banco Santander"),
                  //   rates: CardBankRates(
                  //     buyValue: 89.02,
                  //     sellValue: 96.05,
                  //     sellValueWithTaxes: 158.03,
                  //   ),
                  //   logo: CardLogo(
                  //     iconAsset: DolarBotIcons.banks.santander,
                  //     tag: "Dolar",
                  //   ),
                  //   lastUpdated: CardLastUpdated(
                  //     timestamp:
                  //         DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  //   ),
                  //   gradiantColors: DolarBotConstants.kGradiantSantander,
                  // ),
                  // CardBank(
                  //   header: CardHeader(title: "Banco BBVA"),
                  //   rates: CardBankRates(
                  //     buyValue: 89.02,
                  //     sellValue: 96.05,
                  //     sellValueWithTaxes: 158.03,
                  //   ),
                  //   logo: CardLogo(
                  //     iconAsset: DolarBotIcons.banks.bbva,
                  //     tag: "Euro",
                  //   ),
                  //   lastUpdated: CardLastUpdated(
                  //     timestamp:
                  //         DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  //   ),
                  //   gradiantColors: DolarBotConstants.kGradiantBBVA,
                  // ),
                  // CardBank(
                  //   header: CardHeader(title: "Banco Ciudad"),
                  //   rates: CardBankRates(
                  //     buyValue: 89.02,
                  //     sellValue: 96.05,
                  //     sellValueWithTaxes: 158.03,
                  //   ),
                  //   logo: CardLogo(
                  //     iconAsset: DolarBotIcons.banks.ciudad,
                  //     tag: "Dolar",
                  //   ),
                  //   lastUpdated: CardLastUpdated(
                  //     timestamp:
                  //         DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  //   ),
                  //   gradiantColors: DolarBotConstants.kGradiantCiudad,
                  // ),
                  // CardBank(
                  //   header: CardHeader(title: "Banco Galicia"),
                  //   rates: CardBankRates(
                  //     buyValue: 89.02,
                  //     sellValue: 96.05,
                  //     sellValueWithTaxes: 158.03,
                  //   ),
                  //   logo: CardLogo(
                  //     iconAsset: DolarBotIcons.banks.galicia,
                  //     tag: "Dolar",
                  //   ),
                  //   lastUpdated: CardLastUpdated(
                  //     timestamp:
                  //         DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  //   ),
                  //   gradiantColors: DolarBotConstants.kGradiantGalicia,
                  // ),
                  // CardBank(
                  //   header: CardHeader(title: "Banco de Córdoba"),
                  //   rates: CardBankRates(
                  //     buyValue: 89.02,
                  //     sellValue: 96.05,
                  //     sellValueWithTaxes: 158.03,
                  //   ),
                  //   logo: CardLogo(
                  //     iconAsset: DolarBotIcons.banks.cordoba,
                  //     tag: "Dolar",
                  //   ),
                  //   lastUpdated: CardLastUpdated(
                  //     timestamp:
                  //         DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  //   ),
                  //   gradiantColors: DolarBotConstants.kGradiantCordoba,
                  // ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
