import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/bcra_info/bcra_info_screen.dart';
import 'package:dolarbot_app/screens/crypto_info/crypto_info_screen.dart';
import 'package:dolarbot_app/screens/currency_info/currency_info_screen.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/root_menus/root_menu_bcra.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/root_menus/root_menu_venezuela.dart';
import 'package:dolarbot_app/screens/metal_info/metal_info_screen.dart';
import 'package:dolarbot_app/screens/venezuela_info/venezuela_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenuBody extends StatelessWidget {
  final GlobalKey<CurrencyInfoScreenState> _keyCurrencyInfo = GlobalKey();
  final GlobalKey<CryptoInfoScreenState> _keyCryptoInfo = GlobalKey();
  final GlobalKey<MetalInfoScreenState> _keyMetalInfo = GlobalKey();
  final GlobalKey<BcraInfoScreenState> _keyBCRA = GlobalKey();
  final GlobalKey<VenezuelaInfoScreenState> _keyVenezuela = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Function _refreshCurrencyInfo =
        () => _keyCurrencyInfo.currentState.refresh();
    Function _refreshCryptoInfo = () => _keyCryptoInfo.currentState.refresh();
    Function _refreshMetalInfo = () => _keyMetalInfo.currentState.refresh();
    Function _refreshBCRA = () => _keyBCRA.currentState.refresh();
    Function _refreshVenezuela = () => _keyVenezuela.currentState.refresh();

    MenuItem _getDollarRootMenu(BuildContext context) {
      return MenuItem(
        text: "Dólar",
        leading: getIconData(context, FontAwesomeIcons.dollarSign),
        depthLevel: 1,
        disableSplash: true,
        subItems: [
          MenuItem(
            text: "Oficial",
            leading: getIconData(context, FontAwesomeIcons.solidCheckCircle),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                context: context,
                title: 'Dólar Oficial',
                bodyContent: CurrencyInfoScreen<DollarResponse>(
                  dollarEndpoint: DollarEndpoints.oficial,
                  key: _keyCurrencyInfo,
                ),
                onRefresh: _refreshCurrencyInfo,
              ),
            },
          ),
          MenuItem(
            text: "Blue",
            leading: getIconData(context, FontAwesomeIcons.commentDollar),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                context: context,
                title: 'Dólar Blue',
                bodyContent: CurrencyInfoScreen<DollarResponse>(
                  dollarEndpoint: DollarEndpoints.blue,
                ),
                onRefresh: _refreshCurrencyInfo,
              )
            },
          ),
          MenuItem(
            text: "Bolsa (MEP)",
            leading: getIconData(context, FontAwesomeIcons.poll),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                context: context,
                title: 'Dólar Bolsa (MEP)',
                bodyContent: CurrencyInfoScreen<DollarResponse>(
                  dollarEndpoint: DollarEndpoints.bolsa,
                ),
                onRefresh: _refreshCurrencyInfo,
              )
            },
          ),
          MenuItem(
            text: "Contado con Liqui",
            leading: getIconData(context, FontAwesomeIcons.coins),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                context: context,
                title: 'Dólar Contado con Liquidación',
                bodyContent: CurrencyInfoScreen<DollarResponse>(
                  dollarEndpoint: DollarEndpoints.contadoLiqui,
                ),
                onRefresh: _refreshCurrencyInfo,
              )
            },
          ),
          MenuItem(
            text: "Promedio",
            leading: getIconData(context, FontAwesomeIcons.percentage),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                context: context,
                title: 'Dólar Promedio',
                bodyContent: CurrencyInfoScreen<DollarResponse>(
                  dollarEndpoint: DollarEndpoints.promedio,
                ),
                onRefresh: _refreshCurrencyInfo,
              )
            },
          ),
          MenuItem(
            text: "Bancos",
            leading: getIconData(context, FontAwesomeIcons.landmark),
            depthLevel: 2,
            subItems: [
              MenuItem(
                text: "BBVA",
                leading: getIconAsset(context, DolarBotIcons.banks.bbva),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - BBVA',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.bbva,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Chaco",
                leading: getIconAsset(context, DolarBotIcons.banks.chaco),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Nuevo Banco del Chaco',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.chaco,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Ciudad",
                leading: getIconAsset(context, DolarBotIcons.banks.ciudad),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Ciudad',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.ciudad,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Comafi",
                leading: getIconAsset(context, DolarBotIcons.banks.comafi),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Comafi',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.comafi,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Córdoba",
                leading: getIconAsset(context, DolarBotIcons.banks.cordoba),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco de Córdoba',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.bancor,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Galicia",
                leading: getIconAsset(context, DolarBotIcons.banks.galicia),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Galicia',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.galicia,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Hipotecario",
                leading: getIconAsset(context, DolarBotIcons.banks.hipotecario),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Hipotecario',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.hipotecario,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "BIND",
                leading: getIconAsset(context, DolarBotIcons.banks.bind),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Industrial (BIND)',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.bind,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "La Pampa",
                leading: getIconAsset(context, DolarBotIcons.banks.pampa),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco de La Pampa',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.pampa,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Nación",
                leading: getIconAsset(context, DolarBotIcons.banks.nacion),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Nación',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.nacion,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Patagonia",
                leading: getIconAsset(context, DolarBotIcons.banks.patagonia),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Patagonia',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.patagonia,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Piano",
                leading: getIconAsset(context, DolarBotIcons.banks.piano),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Piano',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.piano,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Santander",
                leading: getIconAsset(context, DolarBotIcons.banks.santander),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Santander',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.santander,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
              MenuItem(
                text: "Supervielle",
                leading: getIconAsset(context, DolarBotIcons.banks.supervielle),
                depthLevel: 3,
                onTap: () => {
                  navigateTo(
                    context: context,
                    title: 'Dólar - Banco Supervielle',
                    bodyContent: CurrencyInfoScreen<DollarResponse>(
                      dollarEndpoint: DollarEndpoints.supervielle,
                    ),
                    onRefresh: _refreshCurrencyInfo,
                  )
                },
              ),
            ],
          )
        ],
      );
    }

    MenuItem _getEuroRootMenu(BuildContext context) {
      return MenuItem(
        text: "Euro",
        leading: getIconData(context, FontAwesomeIcons.euroSign),
        depthLevel: 1,
        disableSplash: true,
        subItems: [
          MenuItem(
            text: "BBVA",
            leading: getIconAsset(context, DolarBotIcons.banks.bbva),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Euro - Banco BBVA',
                  bodyContent: CurrencyInfoScreen<EuroResponse>(
                    euroEndpoint: EuroEndpoints.bbva,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
          MenuItem(
            text: "Chaco",
            leading: getIconAsset(context, DolarBotIcons.banks.chaco),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Euro - Nuevo Banco del Chaco',
                  bodyContent: CurrencyInfoScreen<EuroResponse>(
                    euroEndpoint: EuroEndpoints.chaco,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
          MenuItem(
            text: "Galicia",
            leading: getIconAsset(context, DolarBotIcons.banks.galicia),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Euro - Banco Galicia',
                  bodyContent: CurrencyInfoScreen<EuroResponse>(
                    euroEndpoint: EuroEndpoints.galicia,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
          MenuItem(
            text: "Hipotecario",
            leading: getIconAsset(context, DolarBotIcons.banks.hipotecario),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Euro - Banco Hipotecario',
                  bodyContent: CurrencyInfoScreen<EuroResponse>(
                    euroEndpoint: EuroEndpoints.hipotecario,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
          MenuItem(
            text: "La Pampa",
            leading: getIconAsset(context, DolarBotIcons.banks.pampa),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Euro - Banco de La Pampa',
                  bodyContent: CurrencyInfoScreen<EuroResponse>(
                    euroEndpoint: EuroEndpoints.pampa,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
          MenuItem(
            text: "Nación",
            leading: getIconAsset(context, DolarBotIcons.banks.nacion),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Euro - Banco Nación',
                  bodyContent: CurrencyInfoScreen<EuroResponse>(
                    euroEndpoint: EuroEndpoints.nacion,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
        ],
      );
    }

    MenuItem _getRealRootMenu(BuildContext context) {
      return MenuItem(
        text: "Real",
        leading: getIconAsset(context, DolarBotIcons.general.real),
        depthLevel: 1,
        disableSplash: true,
        subItems: [
          MenuItem(
            text: "BBVA",
            leading: getIconAsset(context, DolarBotIcons.banks.bbva),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Real - Banco BBVA',
                  bodyContent: CurrencyInfoScreen<RealResponse>(
                    realEndpoint: RealEndpoints.bbva,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
          MenuItem(
            text: "Chaco",
            leading: getIconAsset(context, DolarBotIcons.banks.chaco),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Real - Nuevo Banco del Chaco',
                  bodyContent: CurrencyInfoScreen<RealResponse>(
                    realEndpoint: RealEndpoints.chaco,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
          MenuItem(
            text: "Nación",
            leading: getIconAsset(context, DolarBotIcons.banks.nacion),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Real - Banco Nación',
                  bodyContent: CurrencyInfoScreen<RealResponse>(
                    realEndpoint: RealEndpoints.nacion,
                    key: _keyCurrencyInfo,
                  ),
                  onRefresh: _refreshCurrencyInfo)
            },
          ),
        ],
      );
    }

    MenuItem _getCryptoRootMenu(BuildContext context) {
      return MenuItem(
        text: "Crypto",
        leading: getIconData(context, CryptoFontIcons.TRIG),
        depthLevel: 1,
        disableSplash: true,
        subItems: [
          MenuItem(
            text: "Bitcoin",
            leading: getIconData(context, CryptoFontIcons.BTC),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Bitcoin (BTC)',
                  bodyContent: CryptoInfoScreen(
                    cryptoEndpoint: CryptoEndpoints.bitcoin,
                    key: _keyCryptoInfo,
                  ),
                  onRefresh: _refreshCryptoInfo)
            },
          ),
          MenuItem(
            text: "Bitcoin Cash",
            leading: getIconData(context, CryptoFontIcons.BTC_ALT),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Bitcoin Cash (BCH)',
                  bodyContent: CryptoInfoScreen(
                    cryptoEndpoint: CryptoEndpoints.bitcoincash,
                    key: _keyCryptoInfo,
                  ),
                  onRefresh: _refreshCryptoInfo)
            },
          ),
          MenuItem(
            text: "DASH",
            leading: getIconData(context, CryptoFontIcons.DASH),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'DASH',
                  bodyContent: CryptoInfoScreen(
                    cryptoEndpoint: CryptoEndpoints.dash,
                    key: _keyCryptoInfo,
                  ),
                  onRefresh: _refreshCryptoInfo)
            },
          ),
          MenuItem(
            text: "Ethereum",
            leading: getIconData(context, FontAwesomeIcons.ethereum),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Ethereum (ETH)',
                  bodyContent: CryptoInfoScreen(
                    cryptoEndpoint: CryptoEndpoints.ethereum,
                    key: _keyCryptoInfo,
                  ),
                  onRefresh: _refreshCryptoInfo)
            },
          ),
          MenuItem(
            text: "Litecoin",
            leading: getIconData(context, CryptoFontIcons.LTC),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Litecoin (LTC)',
                  bodyContent: CryptoInfoScreen(
                    cryptoEndpoint: CryptoEndpoints.litecoin,
                    key: _keyCryptoInfo,
                  ),
                  onRefresh: _refreshCryptoInfo)
            },
          ),
          MenuItem(
            text: "Monero",
            leading: getIconData(context, CryptoFontIcons.XMR),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Monero (XMR)',
                  bodyContent: CryptoInfoScreen(
                    cryptoEndpoint: CryptoEndpoints.monero,
                    key: _keyCryptoInfo,
                  ),
                  onRefresh: _refreshCryptoInfo)
            },
          ),
          MenuItem(
            text: "Ripple",
            leading: getIconData(context, CryptoFontIcons.XRP),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Ripple (XRP)',
                  bodyContent: CryptoInfoScreen(
                    cryptoEndpoint: CryptoEndpoints.ripple,
                    key: _keyCryptoInfo,
                  ),
                  onRefresh: _refreshCryptoInfo)
            },
          ),
        ],
      );
    }

    MenuItem _getMetalsRootMenu(BuildContext context) {
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
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Oro',
                  bodyContent: MetalInfoScreen(
                    metalEndpoint: MetalEndpoints.oro,
                    key: _keyMetalInfo,
                  ),
                  onRefresh: _refreshMetalInfo)
            },
          ),
          MenuItem(
            text: "Plata",
            leading: getIconAsset(context, DolarBotIcons.metals.silver),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Plata',
                  bodyContent: MetalInfoScreen(
                    metalEndpoint: MetalEndpoints.plata,
                    key: _keyMetalInfo,
                  ),
                  onRefresh: _refreshMetalInfo)
            },
          ),
          MenuItem(
            text: "Cobre",
            leading: getIconAsset(context, DolarBotIcons.metals.copper),
            depthLevel: 2,
            onTap: () => {
              navigateTo(
                  context: context,
                  title: 'Cobre',
                  bodyContent: MetalInfoScreen(
                    metalEndpoint: MetalEndpoints.cobre,
                    key: _keyMetalInfo,
                  ),
                  onRefresh: _refreshMetalInfo)
            },
          ),
        ],
      );
    }

    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _getDollarRootMenu(context),
            _getEuroRootMenu(context),
            _getRealRootMenu(context),
            _getCryptoRootMenu(context),
            _getMetalsRootMenu(context),
            RootMenuBCRA(key: _keyBCRA, onRefresh: _refreshBCRA),
            RootMenuVenezuela(key: _keyVenezuela, onRefresh: _refreshVenezuela)
          ],
        ),
      ),
    );
  }
}

getIconAsset(BuildContext context, String assetPath) {
  return Image.asset(
    assetPath,
    color: ThemeManager.getDrawerMenuItemIconColor(context),
    width: 24,
    height: 24,
    filterQuality: FilterQuality.high,
  );
}

getIconData(BuildContext context, IconData iconData) {
  return Icon(
    iconData,
    color: ThemeManager.getDrawerMenuItemIconColor(context),
  );
}

navigateTo({
  BuildContext context,
  String title,
  Widget bodyContent,
  Function onRefresh,
}) async {
  Navigator.pop(context, true);
  await Future.delayed(Duration(milliseconds: 200)).then(
    (value) => Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomeScreen(
          title: title,
          bodyContent: bodyContent,
          onAppBarRefresh: onRefresh,
        ),
      ),
    ),
  );
}
