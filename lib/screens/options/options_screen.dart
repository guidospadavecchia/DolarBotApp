import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../classes/app_config.dart';
import '../../classes/size_config.dart';
import '../../classes/theme_manager.dart';
import '../../util/util.dart';
import '../../widgets/common/cool_app_bar.dart';
import '../../widgets/common/menu_item.dart';
import '../../widgets/common/toasts/toast_error.dart';
import '../base/base_info_screen.dart';
import 'widgets/card_gesture_dismiss_dialog/card_gesture_dismiss_dialog.dart';
import 'widgets/card_tag_colors_dialog/card_tag_colors_dialog.dart';
import 'widgets/clear_historical_data_dialog/clear_historical_data_dialog.dart';
import 'widgets/fab_direction_dialog/fab_direction_dialog.dart';
import 'widgets/format_currency_dialog/format_currency_dialog.dart';

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
    return PopScope(
      onPopInvoked: (didPop) => _onWillPopScope(context),
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
          overScroll.disallowIndicator();
          return false;
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDivider("Apariencia", supressPaddingTop: true),
            MenuItem(
              text: "Modo oscuro",
              subtitle: "Habilita o deshabilita el modo oscuro",
              leading: Icon(
                FontAwesomeIcons.solidMoon,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
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
            ),
            _buildDivider("Preferencias"),
            MenuItem(
              text: "Formato de moneda",
              subtitle: "Cambia el formato de moneda entre AR y US",
              leading: Icon(
                FontAwesomeIcons.earthAmericas,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              onTap: () => _showFormatCurrencyDialog(context),
              disableHighlight: false,
            ),
            MenuItem(
              text: "Menú de acciones",
              subtitle: "Permite elegir entre despliegue horizontal y vertical",
              leading: Icon(
                FontAwesomeIcons.ellipsis,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              onTap: () => _showFabDirectionDialog(context),
              disableHighlight: false,
            ),
            MenuItem(
              text: "Gesto de eliminación de tarjeta",
              subtitle: "Ajusta el gesto para eliminar tarjetas en el Inicio",
              leading: Icon(
                FontAwesomeIcons.rightLeft,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              onTap: () => _showCardGestureDismissDialog(context),
              disableHighlight: false,
            ),
            if (AppConfig.isProVersion)
              MenuItem(
                text: "Etiquetas de colores",
                subtitle: "Diferencia las etiquetas de monedas por color",
                leading: Icon(
                  FontAwesomeIcons.tag,
                  color: ThemeManager.getDrawerMenuItemIconColor(context),
                ),
                depthLevel: 1,
                onTap: () => _showCardTagColorsDialog(context),
                disableHighlight: false,
              ),
            _buildDivider("Otros"),
            MenuItem(
              text: "Ayuda",
              subtitle: "Muestra una breve guía sobre la aplicación",
              leading: Icon(
                FontAwesomeIcons.solidCircleQuestion,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              disableHighlight: false,
              onTap: () {
                dismissAllToast();
                Util.showFirstTimeDialog(context, true);
              },
            ),
            MenuItem(
              text: "Contacto",
              subtitle: "¿Problemas o sugerencias? ¡Escribínos!",
              leading: Icon(
                FontAwesomeIcons.solidEnvelope,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              disableHighlight: false,
              onTap: () => _showSendMail(context),
            ),
            if (AppConfig.isProVersion)
              MenuItem(
                text: "Limpiar cotizaciones históricas",
                subtitle: "Elimina los datos de las cotizaciones consultadas",
                leading: Icon(
                  FontAwesomeIcons.eraser,
                  color: ThemeManager.getDrawerMenuItemIconColor(context),
                ),
                depthLevel: 1,
                disableHighlight: false,
                onTap: () => _showClearHistoricalDataDialog(context),
              ),
            MenuItem(
              text: "Información de la aplicación",
              subtitle: "Versión del producto y enlaces",
              leading: Icon(
                FontAwesomeIcons.circleInfo,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              disableHighlight: false,
              onTap: () => Navigator.of(context).pushNamed("/about"),
            ),
            _buildDivider("Legales"),
            MenuItem(
              text: "Términos de uso",
              subtitle: "La letra chica",
              leading: Icon(
                FontAwesomeIcons.solidFileLines,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              disableHighlight: false,
              onTap: () => _showTermsAndConditions(context),
            ),
            MenuItem(
              text: "Política de Privacidad",
              subtitle: "Qué datos recolectamos",
              leading: Icon(
                FontAwesomeIcons.fileContract,
                color: ThemeManager.getDrawerMenuItemIconColor(context),
              ),
              depthLevel: 1,
              disableHighlight: false,
              onTap: () => _showPrivacyPolicy(context),
            ),
          ],
        ),
      ),
    );
  }

  bool _onWillPopScope(BuildContext context) {
    dismissAllToast();
    return true;
  }

  _buildDivider(String text, {bool supressPaddingTop = false}) {
    final EdgeInsets dividerPadding = EdgeInsets.only(
      bottom: SizeConfig.blockSizeVertical,
      top: supressPaddingTop ? 0 : SizeConfig.blockSizeVertical,
    );
    final EdgeInsets innerPadding = EdgeInsets.only(
      left: SizeConfig.blockSizeHorizontal * 5,
      top: supressPaddingTop ? 0 : SizeConfig.blockSizeVertical * 2,
    );
    return Padding(
      padding: dividerPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: supressPaddingTop ? 0 : SizeConfig.blockSizeVertical * 1.5,
            color: ThemeManager.getDividerColor(context),
          ),
          Padding(
            padding: innerPadding,
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  fontSize: SizeConfig.blockSizeVertical * 2,
                  color: ThemeManager.getPrimaryAccentColor(context)),
            ),
          ),
        ],
      ),
    );
  }

  _showClearHistoricalDataDialog(BuildContext context) {
    dismissAllToast();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ClearHistoricalDataDialog();
      },
    );
  }

  _showFormatCurrencyDialog(BuildContext context) {
    dismissAllToast();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FormatCurrencyDialog();
      },
    );
  }

  _showFabDirectionDialog(BuildContext context) {
    dismissAllToast();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FabDirectionDialog();
      },
    );
  }

  _showSendMail(BuildContext context) {
    dismissAllToast();
    String? contactEmail = Util.cfg.getDeepValue<String>("contactEmail");
    if (contactEmail != null && contactEmail.trim() != '') {
      String subject = Uri.encodeComponent("Hola DolarBot!");
      Util.launchURL("mailto:$contactEmail?subject=$subject");
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => showToastWidget(ToastError()),
      );
    }
  }

  _showPrivacyPolicy(BuildContext context) {
    dismissAllToast();
    String? url = Util.cfg.getDeepValue<String>("privacyPolicyUrl");
    if (url != null && url.trim() != '') {
      Util.launchURL(url);
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => showToastWidget(ToastError()),
      );
    }
  }

  _showTermsAndConditions(BuildContext context) {
    dismissAllToast();
    String? url = Util.cfg.getDeepValue<String>("termsOfServiceUrl");
    if (url != null && url.trim() != '') {
      Util.launchURL(url);
    } else {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => showToastWidget(ToastError()),
      );
    }
  }

  _showCardGestureDismissDialog(BuildContext context) {
    dismissAllToast();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CardGestureDismissDialog();
      },
    );
  }

  _showCardTagColorsDialog(BuildContext context) {
    dismissAllToast();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CardTagColorsDialog();
      },
    );
  }
}
