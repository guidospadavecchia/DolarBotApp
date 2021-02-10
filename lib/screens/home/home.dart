import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/classes/endpoints/moenda_generica.dart';
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
  MonedaGenerica monedaGenerica;

  @override
  void initState() {
    super.initState();

    API.getDolar().then((response) {
      monedaGenerica = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leadingWidth: 80,
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
      drawerEdgeDragWidth: 200,
      drawerEnableOpenDragGesture: true,
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(bottom: 80),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: CurrencyInfoContainer(
            items: [
              CurrencyInfo(
                title: "COMPRA",
                symbol: '\$',
                value: monedaGenerica.compra,
              ),
              CurrencyInfo(
                title: "VENTA",
                symbol: '\$',
                value: monedaGenerica.venta,
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
