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
              bank: "Banco Supervielle",
              icon: DolarBotIcons.banks.supervielle,
              moneyType: "DOLAR",
              gradiantColors: [
                Color.fromRGBO(230, 46, 46, 1),
                Color.fromRGBO(128, 13, 70, 1),
              ],
            ),
            CardBank(
              bank: "Banco Galicia",
              icon: DolarBotIcons.banks.galicia,
              moneyType: "DOLAR",
              gradiantColors: [
                Color.fromRGBO(254, 106, 10, 1),
                Color.fromRGBO(196, 0, 34, 1),
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
              padding: EdgeInsets.only(left: 15, top: 20),
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
                  Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      moneyType.toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bank,
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
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
                alignment: Alignment.topCenter,
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
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Text(
        "🕑 Última actualización: 24/02/2021 - 23:08 hs.",
        style: TextStyle(
            fontSize: 12,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.normal,
            color: Colors.white54),
      ),
    );
  }
}

class BankPrices extends StatelessWidget {
  const BankPrices({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                "Compra",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 2),
              child: Text(
                "💵 \$89,02",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 2, left: 70),
              child: Text(
                "Venta",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 2, left: 70),
              child: Text(
                "💵 \$156,78",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
