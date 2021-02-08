import 'package:dolarbot_app/classes/theme/theme_manager.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/screens/home/widgets/floating_action_button/home_floating_action_button.dart';
import 'package:dolarbot_app/widgets/common/currency_info.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
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
        centerTitle: true,
        title: Text(
          "Dólar Oficial",
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            color: ThemeManager.getPrimaryTextColor(context),
          ),
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        child: DrawerMenu(),
      ),
      drawerEdgeDragWidth: 250,
      drawerEnableOpenDragGesture: true,
      body: Container(
        padding: EdgeInsets.only(top: 10),
        color: Colors.transparent,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.7,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: CurrencyInfoContainer(
            items: [
              CurrencyInfo(
                title: "COMPRA",
                symbol: '\$',
                value: '80.33',
              ),
              CurrencyInfo(
                title: "VENTA",
                symbol: '\$',
                value: '90.33',
              ),
              CurrencyInfo(
                title: "OTRA",
                symbol: '\$',
                value: '145.33',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: HomeFloatingActionButton(),
      floatingActionButtonLocation: HomeFloatingActionButton.getLocation(),
    );
  }
}
