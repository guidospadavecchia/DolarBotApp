import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/bcra_info/bcra_info_screen.dart';
import 'package:dolarbot_app/screens/crypto_info/crypto_info_screen.dart';
import 'package:dolarbot_app/screens/currency_info/currency_info_screen.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/screens/metal_info/metal_info_screen.dart';
import 'package:dolarbot_app/screens/venezuela_info/venezuela_info_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenuBody extends StatelessWidget {
  const DrawerMenuBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            _getBcraRootMenu(context),
            _getVenezuelaRootMenu(context)
          ],
        ),
      ),
    );
  }

  _getIconAsset(BuildContext context, String assetPath) {
    return Image.asset(
      assetPath,
      color: ThemeManager.getDrawerMenuItemIconColor(context),
      width: 24,
      height: 24,
      filterQuality: FilterQuality.high,
    );
  }

  _getIconData(BuildContext context, IconData iconData) {
    return Icon(
      iconData,
      color: ThemeManager.getDrawerMenuItemIconColor(context),
    );
  }

  _navigateTo(BuildContext context, String title, Widget bodyContent) async {
    Navigator.pop(context, true);
    await Future.delayed(Duration(milliseconds: 200)).then(
      (value) => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomeScreen(
            title: title,
            bodyContent: bodyContent,
          ),
        ),
      ),
    );
  }

  MenuItem _getDollarRootMenu(BuildContext context) {
    return MenuItem(
      text: "Dólar",
      leading: _getIconData(context, FontAwesomeIcons.dollarSign),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Oficial",
          leading: _getIconData(context, FontAwesomeIcons.solidCheckCircle),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Dólar Oficial',
              CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.oficial,
              ),
            )
          },
        ),
        MenuItem(
          text: "Blue",
          leading: _getIconData(context, FontAwesomeIcons.commentDollar),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Dólar Blue',
              CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.blue,
              ),
            )
          },
        ),
        MenuItem(
          text: "Bolsa (MEP)",
          leading: _getIconData(context, FontAwesomeIcons.poll),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Dólar Bolsa (MEP)',
              CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.bolsa,
              ),
            )
          },
        ),
        MenuItem(
          text: "Contado con Liqui",
          leading: _getIconData(context, FontAwesomeIcons.coins),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Dólar Contado con Liquidación',
              CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.contadoLiqui,
              ),
            )
          },
        ),
        MenuItem(
          text: "Promedio",
          leading: _getIconData(context, FontAwesomeIcons.percentage),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Dólar Promedio',
              CurrencyInfoScreen<DollarResponse>(
                dollarEndpoint: DollarEndpoints.promedio,
              ),
            )
          },
        ),
        MenuItem(
          text: "Bancos",
          leading: _getIconData(context, FontAwesomeIcons.landmark),
          depthLevel: 2,
          subItems: [
            MenuItem(
              text: "BBVA",
              leading: _getIconAsset(context, DolarBotIcons.banks.bbva),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - BBVA',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.bbva,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Chaco",
              leading: _getIconAsset(context, DolarBotIcons.banks.chaco),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Nuevo Banco del Chaco',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.chaco,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Ciudad",
              leading: _getIconAsset(context, DolarBotIcons.banks.ciudad),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Ciudad',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.ciudad,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Comafi",
              leading: _getIconAsset(context, DolarBotIcons.banks.comafi),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Comafi',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.comafi,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Córdoba",
              leading: _getIconAsset(context, DolarBotIcons.banks.cordoba),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco de Córdoba',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.bancor,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Galicia",
              leading: _getIconAsset(context, DolarBotIcons.banks.galicia),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Galicia',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.galicia,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Hipotecario",
              leading: _getIconAsset(context, DolarBotIcons.banks.hipotecario),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Hipotecario',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.hipotecario,
                  ),
                )
              },
            ),
            MenuItem(
              text: "BIND",
              leading: _getIconAsset(context, DolarBotIcons.banks.bind),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Industrial (BIND)',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.bind,
                  ),
                )
              },
            ),
            MenuItem(
              text: "La Pampa",
              leading: _getIconAsset(context, DolarBotIcons.banks.pampa),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco de La Pampa',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.pampa,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Nación",
              leading: _getIconAsset(context, DolarBotIcons.banks.nacion),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Nación',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.nacion,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Patagonia",
              leading: _getIconAsset(context, DolarBotIcons.banks.patagonia),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Patagonia',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.patagonia,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Piano",
              leading: _getIconAsset(context, DolarBotIcons.banks.piano),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Piano',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.piano,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Santander",
              leading: _getIconAsset(context, DolarBotIcons.banks.santander),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Santander',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.santander,
                  ),
                )
              },
            ),
            MenuItem(
              text: "Supervielle",
              leading: _getIconAsset(context, DolarBotIcons.banks.supervielle),
              depthLevel: 3,
              onTap: () => {
                _navigateTo(
                  context,
                  'Dólar - Banco Supervielle',
                  CurrencyInfoScreen<DollarResponse>(
                    dollarEndpoint: DollarEndpoints.supervielle,
                  ),
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
      leading: _getIconData(context, FontAwesomeIcons.euroSign),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: _getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Euro - Banco BBVA',
              CurrencyInfoScreen<EuroResponse>(
                  euroEndpoint: EuroEndpoints.bbva),
            )
          },
        ),
        MenuItem(
          text: "Chaco",
          leading: _getIconAsset(context, DolarBotIcons.banks.chaco),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Euro - Nuevo Banco del Chaco',
              CurrencyInfoScreen<EuroResponse>(
                  euroEndpoint: EuroEndpoints.chaco),
            )
          },
        ),
        MenuItem(
          text: "Galicia",
          leading: _getIconAsset(context, DolarBotIcons.banks.galicia),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Euro - Banco Galicia',
              CurrencyInfoScreen<EuroResponse>(
                  euroEndpoint: EuroEndpoints.galicia),
            )
          },
        ),
        MenuItem(
          text: "Hipotecario",
          leading: _getIconAsset(context, DolarBotIcons.banks.hipotecario),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Euro - Banco Hipotecario',
              CurrencyInfoScreen<EuroResponse>(
                  euroEndpoint: EuroEndpoints.hipotecario),
            )
          },
        ),
        MenuItem(
          text: "La Pampa",
          leading: _getIconAsset(context, DolarBotIcons.banks.pampa),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Euro - Banco de La Pampa',
              CurrencyInfoScreen<EuroResponse>(
                  euroEndpoint: EuroEndpoints.pampa),
            )
          },
        ),
        MenuItem(
          text: "Nación",
          leading: _getIconAsset(context, DolarBotIcons.banks.nacion),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Euro - Banco Nación',
              CurrencyInfoScreen<EuroResponse>(
                  euroEndpoint: EuroEndpoints.nacion),
            )
          },
        ),
      ],
    );
  }

  MenuItem _getRealRootMenu(BuildContext context) {
    return MenuItem(
      text: "Real",
      leading: _getIconAsset(context, DolarBotIcons.general.real),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "BBVA",
          leading: _getIconAsset(context, DolarBotIcons.banks.bbva),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Real - Banco BBVA',
              CurrencyInfoScreen<RealResponse>(
                realEndpoint: RealEndpoints.bbva,
              ),
            )
          },
        ),
        MenuItem(
          text: "Chaco",
          leading: _getIconAsset(context, DolarBotIcons.banks.chaco),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Real - Nuevo Banco del Chaco',
              CurrencyInfoScreen<RealResponse>(
                  realEndpoint: RealEndpoints.chaco),
            )
          },
        ),
        MenuItem(
          text: "Nación",
          leading: _getIconAsset(context, DolarBotIcons.banks.nacion),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Real - Banco Nación',
              CurrencyInfoScreen<RealResponse>(
                  realEndpoint: RealEndpoints.nacion),
            )
          },
        ),
      ],
    );
  }

  MenuItem _getCryptoRootMenu(BuildContext context) {
    return MenuItem(
      text: "Crypto",
      leading: _getIconData(context, CryptoFontIcons.TRIG),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Bitcoin",
          leading: _getIconData(context, CryptoFontIcons.BTC),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Bitcoin (BTC)',
              CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.bitcoin),
            )
          },
        ),
        MenuItem(
          text: "Bitcoin Cash",
          leading: _getIconData(context, CryptoFontIcons.BTC_ALT),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Bitcoin Cash (BCH)',
              CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.bitcoincash),
            )
          },
        ),
        MenuItem(
          text: "DASH",
          leading: _getIconData(context, CryptoFontIcons.DASH),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'DASH',
              CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.dash),
            )
          },
        ),
        MenuItem(
          text: "Ethereum",
          leading: _getIconData(context, FontAwesomeIcons.ethereum),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Ethereum (ETH)',
              CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.ethereum),
            )
          },
        ),
        MenuItem(
          text: "Litecoin",
          leading: _getIconData(context, CryptoFontIcons.LTC),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Litecoin (LTC)',
              CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.litecoin),
            )
          },
        ),
        MenuItem(
          text: "Monero",
          leading: _getIconData(context, CryptoFontIcons.XMR),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Monero (XMR)',
              CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.monero),
            )
          },
        ),
        MenuItem(
          text: "Ripple",
          leading: _getIconData(context, CryptoFontIcons.XRP),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Ripple (XRP)',
              CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.ripple),
            )
          },
        ),
      ],
    );
  }

  MenuItem _getMetalsRootMenu(BuildContext context) {
    return MenuItem(
      text: "Metales",
      leading: _getIconData(context, FontAwesomeIcons.sketch),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Oro",
          leading: _getIconAsset(context, DolarBotIcons.metals.gold),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Oro',
              MetalInfoScreen(metalEndpoint: MetalEndpoints.oro),
            )
          },
        ),
        MenuItem(
          text: "Plata",
          leading: _getIconAsset(context, DolarBotIcons.metals.silver),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Plata',
              MetalInfoScreen(metalEndpoint: MetalEndpoints.plata),
            )
          },
        ),
        MenuItem(
          text: "Cobre",
          leading: _getIconAsset(context, DolarBotIcons.metals.copper),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Cobre',
              MetalInfoScreen(metalEndpoint: MetalEndpoints.cobre),
            )
          },
        ),
      ],
    );
  }

  MenuItem _getBcraRootMenu(BuildContext context) {
    return MenuItem(
      text: "Indicadores BCRA",
      leading: _getIconData(context, FontAwesomeIcons.chartLine),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Riesgo País",
          leading: _getIconData(context, FontAwesomeIcons.exclamationTriangle),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Riesgo País',
              BcraInfoScreen(bcraEndpoint: BcraEndpoints.riesgoPais),
            )
          },
        ),
        MenuItem(
          text: "Reservas",
          leading: _getIconData(context, FontAwesomeIcons.handHoldingUsd),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Reservas del BCRA',
              BcraInfoScreen(bcraEndpoint: BcraEndpoints.reservas),
            )
          },
        ),
        MenuItem(
          text: "Circulante",
          leading: _getIconData(context, FontAwesomeIcons.moneyBillWave),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Dinero en circulación',
              BcraInfoScreen(bcraEndpoint: BcraEndpoints.circulante),
            )
          },
        ),
      ],
    );
  }

  MenuItem _getVenezuelaRootMenu(BuildContext context) {
    return MenuItem(
      text: "Venezuela",
      leading: _getIconAsset(context, DolarBotIcons.general.venezuela),
      depthLevel: 1,
      disableSplash: true,
      subItems: [
        MenuItem(
          text: "Dólar",
          leading: _getIconData(context, FontAwesomeIcons.dollarSign),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Dólar (Venezuela)',
              VenezuelaInfoScreen(vzlaEndpoint: VenezuelaEndpoints.dolar),
            )
          },
        ),
        MenuItem(
          text: "Euro",
          leading: _getIconData(context, FontAwesomeIcons.euroSign),
          depthLevel: 2,
          onTap: () => {
            _navigateTo(
              context,
              'Euro (Venezuela)',
              VenezuelaInfoScreen(vzlaEndpoint: VenezuelaEndpoints.euro),
            )
          },
        ),
      ],
    );
  }
}
