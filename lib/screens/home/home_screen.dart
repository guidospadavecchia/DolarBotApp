import 'package:dolarbot_app/classes/constants.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends BaseInfoScreen {
  final String title;

  HomeScreen({
    Key key,
    this.title,
  }) : super(key: key, title: title);

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
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowGlow();
        return false;
      },
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CardBank(
              bank: "Banco Hipotecario",
              icon: DolarBotIcons.banks.hipotecario,
              moneyType: "DOLAR",
              gradiantColors: DolarBotConstants.kGradiantHipotecario,
            ),
            CardBank(
              bank: "Banco Galicia",
              icon: DolarBotIcons.banks.galicia,
              moneyType: "DOLAR",
              gradiantColors: DolarBotConstants.kGradiantGalicia,
            ),
            CardBank(
              bank: "Banco de Córdoba",
              icon: DolarBotIcons.banks.cordoba,
              moneyType: "DOLAR",
              gradiantColors: DolarBotConstants.kGradiantCordoba,
            ),
            CardBank(
              bank: "Banco BBVA",
              icon: DolarBotIcons.banks.bbva,
              moneyType: "Real",
              gradiantColors: [
                Color.fromRGBO(0, 68, 129, 1),
                Color.fromRGBO(0, 40, 80, 1),
              ],
            ),
            CardBank(
              bank: "Banco Comafi",
              icon: DolarBotIcons.banks.comafi,
              moneyType: "Euro",
              gradiantColors: [
                Color.fromRGBO(106, 134, 48, 1),
                Color.fromRGBO(67, 91, 45, 1),
              ],
            ),
            CardBank(
              bank: "Banco Supervielle",
              icon: DolarBotIcons.banks.supervielle,
              moneyType: "DOLAR",
              gradiantColors: [
                Color.fromRGBO(230, 46, 46, 1),
                Color.fromRGBO(128, 13, 70, 1),
              ],
            ),
            CardBank(
              bank: "Banco Santander",
              icon: DolarBotIcons.banks.santander,
              moneyType: "EURO",
              gradiantColors: [
                Color.fromRGBO(239, 0, 0, 1),
                Color.fromRGBO(140, 0, 0, 1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardBank extends StatelessWidget {
  final List<Color> gradiantColors;
  final String bank;
  final String icon;
  final String moneyType;

  const CardBank({
    Key key,
    @required this.gradiantColors,
    @required this.bank,
    @required this.icon,
    @required this.moneyType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(15),
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradiantColors,
          ),
        ),
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12, top: 17),
              child: Column(
                children: [
                  Container(
                    child: Image.asset(
                      icon,
                      width: 32,
                      height: 32,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      width: 40,
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        moneyType.toUpperCase(),
                        style: TextStyle(
                          fontSize: 8,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bank,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  BankPrices(),
                  LastUpdate(),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(right: 20, top: 15),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LastUpdate extends StatelessWidget {
  const LastUpdate({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "🕑 Última actualización: 24/02/2021 - 23:08 hs.",
      style: TextStyle(
          fontSize: 12,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.normal,
          color: Colors.white54),
    );
  }
}

class BankPrices extends StatelessWidget {
  const BankPrices({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      verticalDirection: VerticalDirection.down,
      direction: Axis.horizontal,
      spacing: 30,
      children: [
        Wrap(
          direction: Axis.vertical,
          children: [
            Text(
              "Compra",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            Text(
              "\$189,00",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Wrap(
          direction: Axis.vertical,
          children: [
            Text(
              "Venta",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            Text(
              "\$95,00",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Wrap(
          direction: Axis.vertical,
          children: [
            Text(
              "Ahorro",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
            Text(
              "\$156,75",
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
