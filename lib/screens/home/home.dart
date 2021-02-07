import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/widgets/common/currency_info_buy_sell.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[600]),
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          child: DrawerMenu(),
        ),
      ),
      body: Center(
        child: CurrencyInfoBuySell(
          symbol: '\$',
          valueBuy: '145.33',
          valueSell: '150.39',
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                  ? Colors.white
                  : Color.fromRGBO(48, 48, 48, 1),
              width: 4),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            AdaptiveTheme.of(context).toggleThemeMode();
          },
          tooltip: 'Opciones',
          elevation: 0,
          child: Icon(Icons.more_horiz),
        ),
      ),
      bottomNavigationBar: Container(
        color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
            ? Colors.green[100]
            : Colors.green[900],
        height: 50,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
