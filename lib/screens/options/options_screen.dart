import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:dolarbot_app/screens/options/widgets/card_gesture_dismiss_dialog/card_gesture_dismiss_dialog.dart';
import 'package:dolarbot_app/screens/options/widgets/fab_direction_dialog/fab_direction_dialog.dart';
import 'package:dolarbot_app/screens/options/widgets/format_currency_dialog/format_currency_dialog.dart';
import 'package:dolarbot_app/screens/options/widgets/clear_historical_data_dialog/clear_historical_data_dialog.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionsScreen extends StatefulWidget {
  static const routeName = '/options';

  OptionsScreen({
    Key? key,
  }) : super(key: key);

  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPopScope(context),
      child: Consumer<Settings>(builder: (context, settings, child) {
        return Scaffold(
          extendBodyBehindAppBar: false,
          resizeToAvoidBottomInset: false,
          appBar: CoolAppBar(
            title: 'Opciones',
            isMainMenu: false,
            foregroundColor: ThemeManager.getPrimaryTextColor(context),
          ),
          body: _body(),
        );
      }),
    );
  }

  Widget _body() {
    return Container(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overScroll) {
          overScroll.disallowGlow();
          return false;
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDivider("Apariencia", supressPaddingTop: true),
            MenuItem(
              text: "Modo oscuro",
              subtitle: "Habilita o deshabilita el modo oscuro",
              leading: const Icon(FontAwesomeIcons.solidMoon),
              trailing: Switch(
                activeColor: ThemeManager.getPrimaryAccentColor(context),
                value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
                onChanged: (bool value) {
                  if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }
                  Provider.of<Settings>(context, listen: false).notifyThemeChange();
                },
              ),
              onTap: () => null,
              depthLevel: 1,
              disableHighlight: true,
            ),
            _buildDivider("Preferencias"),
            MenuItem(
              text: "Formato de moneda",
              subtitle: "Cambia el formato de moneda entre AR y US",
              leading: const Icon(FontAwesomeIcons.globeAmericas),
              depthLevel: 1,
              onTap: () => _showFormatCurrencyDialog(context),
              disableHighlight: false,
            ),
            MenuItem(
              text: "Menú de acciones",
              subtitle: "Permite elegir entre despliegue horizontal y vertical",
              leading: const Icon(FontAwesomeIcons.ellipsisH),
              depthLevel: 1,
              onTap: () => _showFabDirectionDialog(context),
              disableHighlight: false,
            ),
            MenuItem(
              text: "Gesto de eliminación de tarjeta",
              subtitle: "Ajusta el gesto para eliminar tarjetas en el Inicio",
              leading: const Icon(FontAwesomeIcons.exchangeAlt),
              depthLevel: 1,
              onTap: () => _showCardGestureDismissDialog(context),
              disableHighlight: false,
            ),
            _buildDivider("Otros"),
            MenuItem(
                text: "Ayuda",
                subtitle: "Muestra una breve guía sobre la aplicación",
                leading: const Icon(FontAwesomeIcons.solidQuestionCircle),
                depthLevel: 1,
                disableHighlight: false,
                onTap: () {
                  dismissAllToast();
                  Util.showFirstTimeDialog(context, true);
                }),
            MenuItem(
              text: "Información de la aplicación",
              subtitle: "Versión del producto y enlaces",
              leading: const Icon(FontAwesomeIcons.infoCircle),
              depthLevel: 1,
              disableHighlight: false,
              onTap: () => Navigator.of(context).pushNamed("/about"),
            ),
            MenuItem(
              text: "Limpiar cotizaciones históricas",
              subtitle: "Elimina los datos de las cotizaciones consultadas",
              leading: const Icon(FontAwesomeIcons.eraser),
              depthLevel: 1,
              disableHighlight: false,
              onTap: () => _showClearHistoricalDataDialog(context),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPopScope(BuildContext context) {
    dismissAllToast();
    Util.navigateTo(
      context,
      HomeScreen(
        key: GlobalKey<HomeScreenState>(),
      ),
    );
    return Future.value(false);
  }

  _buildDivider(String text, {bool supressPaddingTop = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5, top: supressPaddingTop ? 0 : 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: supressPaddingTop ? 0 : 10,
            color: ThemeManager.getDividerColor(context),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, top: supressPaddingTop ? 0 : 20),
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  fontSize: 14,
                  color: ThemeManager.getPrimaryAccentColor(context)),
            ),
          ),
        ],
      ),
    );
  }

  _showClearHistoricalDataDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClearHistoricalDataDialog();
      },
    );
  }

  _showFormatCurrencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FormatCurrencyDialog();
      },
    );
  }

  _showFabDirectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FabDirectionDialog();
      },
    );
  }

  _showCardGestureDismissDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CardGestureDismissDialog();
      },
    );
  }
}
