import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/options/widgets/format_currency_dialog/format_currency_dialog.dart';
import 'package:dolarbot_app/widgets/common/appBar.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Opciones",
      ),
      body: Container(
        child: Column(
          children: [
            MenuItem(
              text: "Modo oscuro",
              subtitle: "Habilita o deshabilita el modo oscuro",
              leading: Icon(FontAwesomeIcons.solidMoon),
              trailing: Switch(
                inactiveTrackColor: ThemeManager.getAccentColor(),
                inactiveThumbColor: ThemeManager.getGlobalAccentColor(context),
                activeColor: ThemeManager.getGlobalAccentColor(context),
                value: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
                onChanged: (bool value) {
                  AdaptiveTheme.of(context).toggleThemeMode();
                },
              ),
              depthLevel: 1,
              disableSplash: true,
            ),
            MenuItem(
              text: "Formato de moneda",
              subtitle: "Cambia el formato de monda entre AR y US",
              leading: Icon(FontAwesomeIcons.globeAmericas),
              depthLevel: 1,
              onTap: () => {
                _showFormatCurrencyDialog(context),
              },
            ),
          ],
        ),
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
}
