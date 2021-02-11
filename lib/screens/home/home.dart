import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/dollarResponse.dart';
import 'package:dolarbot_app/classes/theme/theme_manager.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/screens/home/widgets/floating_action_button/home_floating_action_button.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget returnWidget;

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
          child: FutureBuilder<DollarResponse>(
              future: API.getDollarRate(DollarEndpoints.oficial),
              builder: (BuildContext context,
                  AsyncSnapshot<DollarResponse> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                  case ConnectionState.none:
                    returnWidget = Padding(
                      child: Center(
                        child: SizedBox(
                            width: 64,
                            height: 64,
                            child: LoadingIndicator(
                              indicatorType: Indicator.ballScale,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                    );
                    break;
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      returnWidget = Text('Error: ${snapshot.error}');
                    } else {
                      returnWidget = CurrencyInfoContainer(
                        items: [
                          CurrencyInfo(
                            title: "COMPRA",
                            symbol: '\$',
                            value: snapshot.data.buyPrice,
                          ),
                          CurrencyInfo(
                            title: "VENTA",
                            symbol: '\$',
                            value: snapshot.data.sellPrice,
                          ),
                        ],
                      );
                    }
                    break;
                }

                return returnWidget;
              }),
        ),
      ),
      floatingActionButton: HomeFloatingActionButton(),
      floatingActionButtonLocation: HomeFloatingActionButton.getLocation(),
    );
  }
}
