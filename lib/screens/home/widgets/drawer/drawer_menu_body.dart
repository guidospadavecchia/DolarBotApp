import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/screens/crypto_info/crypto_info_screen.dart';
import 'package:dolarbot_app/screens/currency_info/currency_info_screen.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu_item.dart';
import 'package:dolarbot_app/screens/metal_info/metal_info_screen.dart';
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
            DrawerMenuItem(
              text: "Dolar",
              leftIcon: FontAwesomeIcons.dollarSign,
              depthLevel: 1,
              subItems: [
                DrawerMenuItem(
                  text: "Oficial",
                  leftIcon: FontAwesomeIcons.solidCheckCircle,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Dolar Oficial',
                      CurrencyInfoScreen<DollarResponse>(
                        dollarEndpoint: DollarEndpoints.oficial,
                      ),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Blue",
                  leftIcon: FontAwesomeIcons.solidCheckSquare,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Dolar Blue',
                      CurrencyInfoScreen<DollarResponse>(
                        dollarEndpoint: DollarEndpoints.blue,
                      ),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Bolsa",
                  leftIcon: FontAwesomeIcons.shoppingBag,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Dolar Bolsa',
                      CurrencyInfoScreen<DollarResponse>(
                        dollarEndpoint: DollarEndpoints.bolsa,
                      ),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Contado Liqui",
                  leftIcon: FontAwesomeIcons.moneyBillWave,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Dolar Contado con Liqui',
                      CurrencyInfoScreen<DollarResponse>(
                        dollarEndpoint: DollarEndpoints.contadoLiqui,
                      ),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Promedio",
                  leftIcon: FontAwesomeIcons.percentage,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Dolar Promedio',
                      CurrencyInfoScreen<DollarResponse>(
                        dollarEndpoint: DollarEndpoints.promedio,
                      ),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Bancos",
                  leftIcon: FontAwesomeIcons.piggyBank,
                  depthLevel: 2,
                  onTap: null,
                  subItems: [
                    DrawerMenuItem(
                      text: "BBVA",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar BBVA',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.bbva,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Chaco",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco del Chaco',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.chaco,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Ciudad",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Ciudad',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.ciudad,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Comafi",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Comafi',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.comafi,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Córdoba",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Bancor',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.bancor,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Galicia",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Galicia',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.galicia,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Hipotecario",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Hipotecario',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.hipotecario,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Industrial",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Industrial',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.bind,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "La Pampa",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco de La Pampa',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.pampa,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Nación",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Nación',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.nacion,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Patagonia",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Patagonia',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.patagonia,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Piano",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Piano',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.piano,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Santander",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Santander',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.santander,
                          ),
                        )
                      },
                    ),
                    DrawerMenuItem(
                      text: "Supervielle",
                      leftIcon: null,
                      depthLevel: 3,
                      onTap: () => {
                        navigateTo(
                          context,
                          'Dolar Banco Supervielle',
                          CurrencyInfoScreen<DollarResponse>(
                            dollarEndpoint: DollarEndpoints.supervielle,
                          ),
                        )
                      },
                    ),
                  ],
                )
              ],
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Euro",
              leftIcon: FontAwesomeIcons.euroSign,
              depthLevel: 1,
              onTap: null,
              subItems: [
                DrawerMenuItem(
                  text: "BBVA",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Euro Banco BBVA',
                      CurrencyInfoScreen<EuroResponse>(
                          euroEndpoint: EuroEndpoints.bbva),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Chaco",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Euro Banco del Chaco',
                      CurrencyInfoScreen<EuroResponse>(
                          euroEndpoint: EuroEndpoints.chaco),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Galicia",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Euro Banco Galicia',
                      CurrencyInfoScreen<EuroResponse>(
                          euroEndpoint: EuroEndpoints.galicia),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Hipotecario",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Euro Banco Hipotecario',
                      CurrencyInfoScreen<EuroResponse>(
                          euroEndpoint: EuroEndpoints.hipotecario),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "La Pampa",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Euro Banco de La Pampa',
                      CurrencyInfoScreen<EuroResponse>(
                          euroEndpoint: EuroEndpoints.pampa),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Nación",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Euro Banco Nación',
                      CurrencyInfoScreen<EuroResponse>(
                          euroEndpoint: EuroEndpoints.nacion),
                    )
                  },
                ),
              ],
            ),
            DrawerMenuItem(
              text: "Real",
              leftIcon: FontAwesomeIcons.solidMoneyBillAlt,
              depthLevel: 1,
              subItems: [
                DrawerMenuItem(
                  text: "BBVA",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Real Banco BBVA',
                      CurrencyInfoScreen<RealResponse>(
                        realEndpoint: RealEndpoints.bbva,
                      ),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Chaco",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Real Banco Chaco',
                      CurrencyInfoScreen<RealResponse>(
                          realEndpoint: RealEndpoints.chaco),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Nación",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Real Banco Nación',
                      CurrencyInfoScreen<RealResponse>(
                          realEndpoint: RealEndpoints.nacion),
                    )
                  },
                ),
              ],
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Crypto",
              leftIcon: FontAwesomeIcons.ethereum,
              depthLevel: 1,
              subItems: [
                DrawerMenuItem(
                  text: "Bitcoin",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Bitcoin',
                      CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.bitcoin),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Bitcoin Cash",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Bitcoin Cash',
                      CryptoInfoScreen(
                          cryptoEndpoint: CryptoEndpoints.bitcoincash),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Dash",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Dash',
                      CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.dash),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Ethereum",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Ethereum',
                      CryptoInfoScreen(
                          cryptoEndpoint: CryptoEndpoints.ethereum),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Litecoin",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Litecoin',
                      CryptoInfoScreen(
                          cryptoEndpoint: CryptoEndpoints.litecoin),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Monero",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Monero',
                      CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.monero),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Ripple",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Ripple',
                      CryptoInfoScreen(cryptoEndpoint: CryptoEndpoints.ripple),
                    )
                  },
                ),
              ],
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Metales",
              leftIcon: FontAwesomeIcons.adjust,
              depthLevel: 1,
              subItems: [
                DrawerMenuItem(
                  text: "Oro",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Oro',
                      MetalInfoScreen(metalEndpoint: MetalEndpoints.oro),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Plata",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Plata',
                      MetalInfoScreen(metalEndpoint: MetalEndpoints.plata),
                    )
                  },
                ),
                DrawerMenuItem(
                  text: "Cobre",
                  leftIcon: null,
                  depthLevel: 2,
                  onTap: () => {
                    navigateTo(
                      context,
                      'Cobre',
                      MetalInfoScreen(metalEndpoint: MetalEndpoints.cobre),
                    )
                  },
                ),
              ],
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Indicadores BCRA",
              leftIcon: FontAwesomeIcons.chartLine,
              depthLevel: 1,
              onTap: null,
            ),
            DrawerMenuItem(
              text: "Venezuela",
              leftIcon: FontAwesomeIcons.solidFlag,
              depthLevel: 1,
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }

  navigateTo(BuildContext context, String title, Widget bodyContent) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          title: title,
          bodyContent: bodyContent,
        ),
      ),
    );
  }
}
