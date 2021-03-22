import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/hive/favorite_rate.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/options/widgets/card_gesture_dismiss_dialog/card_gesture_dismiss_dialog.dart';
import 'package:dolarbot_app/screens/options/widgets/fab_direction_dialog.dart/fab_direction_dialog.dart';
import 'package:dolarbot_app/screens/options/widgets/format_currency_dialog/format_currency_dialog.dart';
import 'package:dolarbot_app/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionsScreen extends BaseInfoScreen {
  static const routeName = '/options';

  OptionsScreen({
    Key key,
  }) : super(
            key: key,
            cardData: CardData(
              title: 'Opciones',
              bannerTitle: null,
              tag: null,
              colors: null,
              endpoint: null,
              responseType: null,
            ));

  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends BaseInfoScreenState<OptionsScreen> with BaseScreen {
  @override
  bool isMainMenu() => false;

  @override
  bool showFabMenu() => false;

  @override
  FabOptionCalculatorDialog getCalculatorWidget() => null;

  @override
  bool extendBodyBehindAppBar() => false;

  @override
  Color setColorAppbar() => ThemeManager.getPrimaryTextColor(context);

  @override
  CardFavorite card() => null;

  @override
  String getShareText() => '';

  @override
  String getShareTitle() => '';

  @override
  Future loadData() => null;

  @override
  FavoriteRate createFavorite() => null;

  @override
  Widget body() {
    return Container(
      child: Column(
        children: [
          _buildDivider("Apariencia", supressPaddingTop: true),
          MenuItem(
            text: "Modo oscuro",
            subtitle: "Habilita o deshabilita el modo oscuro",
            leading: Icon(FontAwesomeIcons.solidMoon),
            trailing: Switch(
              activeColor: ThemeManager.getPrimaryAccentColor(context),
              value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
              onChanged: (bool value) {
                setState(() {
                  AdaptiveTheme.of(context).toggleThemeMode();
                  Provider.of<Settings>(context, listen: false).notifyThemeChange();
                });
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
            leading: Icon(FontAwesomeIcons.globeAmericas),
            depthLevel: 1,
            onTap: () => _showFormatCurrencyDialog(context),
            disableHighlight: false,
          ),
          MenuItem(
            text: "Menú de acciones",
            subtitle: "Permite elegir entre despliegue horizontal y vertical",
            leading: Icon(FontAwesomeIcons.ellipsisH),
            depthLevel: 1,
            onTap: () => _showFabDirectionDialog(context),
            disableHighlight: false,
          ),
          MenuItem(
            text: "Gesto de eliminación de tarjeta",
            subtitle: "Ajusta el gesto para eliminar tarjetas en el Inicio",
            leading: Icon(FontAwesomeIcons.exchangeAlt),
            depthLevel: 1,
            onTap: () => _showCardGestureDismissDialog(context),
            disableHighlight: false,
          ),
          _buildDivider("Otros"),
          MenuItem(
              text: "Ayuda",
              subtitle: "Muestra una breve guía sobre la aplicación",
              leading: Icon(FontAwesomeIcons.solidQuestionCircle),
              depthLevel: 1,
              disableHighlight: false,
              onTap: () {
                dismissAllToast();
                Util.showFirstTimeDialog(context, true);
              }),
          MenuItem(
            text: "Información de la aplicación",
            subtitle: "Versión del producto y enlaces",
            leading: Icon(FontAwesomeIcons.infoCircle),
            depthLevel: 1,
            disableHighlight: false,
            onTap: () => Navigator.of(context).pushNamed("/about"),
          ),
        ],
      ),
    );
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
