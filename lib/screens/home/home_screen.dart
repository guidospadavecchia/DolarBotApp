import 'package:dolarbot_app/classes/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/banks/card_bank.dart';
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
  Widget body() {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 110),
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CardBank(
                  header: CardHeader(title: "Banco Patagonia"),
                  rates: CardBankRates(
                    buyValue: 89.02,
                    sellValue: 96.05,
                    sellValueWithTaxes: 158.03,
                  ),
                  logo: CardLogo(
                    iconAsset: DolarBotIcons.banks.patagonia,
                    tag: "Dolar",
                  ),
                  lastUpdated: CardLastUpdated(
                    timestamp:
                        DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  ),
                  gradiantColors: DolarBotConstants.kGradiantPatagonia,
                ),
                CardBank(
                  header: CardHeader(title: "Banco Santander"),
                  rates: CardBankRates(
                    buyValue: 89.02,
                    sellValue: 96.05,
                    sellValueWithTaxes: 158.03,
                  ),
                  logo: CardLogo(
                    iconAsset: DolarBotIcons.banks.santander,
                    tag: "Dolar",
                  ),
                  lastUpdated: CardLastUpdated(
                    timestamp:
                        DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  ),
                  gradiantColors: DolarBotConstants.kGradiantSantander,
                ),
                CardBank(
                  header: CardHeader(title: "Banco BBVA"),
                  rates: CardBankRates(
                    buyValue: 89.02,
                    sellValue: 96.05,
                    sellValueWithTaxes: 158.03,
                  ),
                  logo: CardLogo(
                    iconAsset: DolarBotIcons.banks.bbva,
                    tag: "Euro",
                  ),
                  lastUpdated: CardLastUpdated(
                    timestamp:
                        DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  ),
                  gradiantColors: DolarBotConstants.kGradiantBBVA,
                ),
                CardBank(
                  header: CardHeader(title: "Banco Ciudad"),
                  rates: CardBankRates(
                    buyValue: 89.02,
                    sellValue: 96.05,
                    sellValueWithTaxes: 158.03,
                  ),
                  logo: CardLogo(
                    iconAsset: DolarBotIcons.banks.ciudad,
                    tag: "Dolar",
                  ),
                  lastUpdated: CardLastUpdated(
                    timestamp:
                        DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  ),
                  gradiantColors: DolarBotConstants.kGradiantCiudad,
                ),
                CardBank(
                  header: CardHeader(title: "Banco Galicia"),
                  rates: CardBankRates(
                    buyValue: 89.02,
                    sellValue: 96.05,
                    sellValueWithTaxes: 158.03,
                  ),
                  logo: CardLogo(
                    iconAsset: DolarBotIcons.banks.galicia,
                    tag: "Dolar",
                  ),
                  lastUpdated: CardLastUpdated(
                    timestamp:
                        DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  ),
                  gradiantColors: DolarBotConstants.kGradiantGalicia,
                ),
                CardBank(
                  header: CardHeader(title: "Banco de Córdoba"),
                  rates: CardBankRates(
                    buyValue: 89.02,
                    sellValue: 96.05,
                    sellValueWithTaxes: 158.03,
                  ),
                  logo: CardLogo(
                    iconAsset: DolarBotIcons.banks.cordoba,
                    tag: "Dolar",
                  ),
                  lastUpdated: CardLastUpdated(
                    timestamp:
                        DateFormat("dd/MM/yyyy - HH:mm").format(DateTime.now()),
                  ),
                  gradiantColors: DolarBotConstants.kGradiantCordoba,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
