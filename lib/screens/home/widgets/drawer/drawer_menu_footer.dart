import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/options/options_screen.dart';
import 'package:dolarbot_app/widgets/common/menu_item.dart';
import 'package:dolarbot_app/widgets/toasts/toast_error.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenuFooter extends StatelessWidget {
  final cfg = GlobalConfiguration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Divider(),
            MenuItem(
              text: "Opciones",
              leading: Icon(FontAwesomeIcons.cog,
                  color: ThemeManager.getDrawerMenuItemIconColor(context)),
              depthLevel: 1,
              onTap: () => {
                Navigator.of(context).popAndPushNamed(OptionsScreen.routeName),
              },
            ),
            MenuItem(
              text: "Salir",
              leading: Icon(FontAwesomeIcons.signOutAlt,
                  color: ThemeManager.getDrawerMenuItemIconColor(context)),
              depthLevel: 1,
              onTap: () => {
                exit(0),
              },
            ),
            Divider(
              height: 1,
            ),
            Container(
              color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                  ? Colors.blueGrey[50]
                  : Colors.grey[900],
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _getDiscord(),
                  SizedBox(
                    width: 30,
                  ),
                  _getGitHub(context),
                ],
              ),
            ),
            _getSloganFlutter(context),
          ],
        ),
      ),
    );
  }

  _getGitHub(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/general/github.png',
          width: 24,
          height: 24,
          filterQuality: FilterQuality.high,
          color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
              ? Colors.black87
              : Colors.white70,
        ),
        SizedBox(
          width: 10,
        ),
        Tooltip(
          message: "Visitanos en GitHub",
          child: RichText(
            text: TextSpan(
              text: "GitHub",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Raleway',
                color: Colors.blueGrey[500],
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launchURL(cfg.get("githubUrl")),
            ),
          ),
        ),
      ],
    );
  }

  _getDiscord() {
    return Row(
      children: [
        Image.asset(
          'assets/images/general/discord.png',
          width: 24,
          height: 24,
          filterQuality: FilterQuality.high,
        ),
        SizedBox(
          width: 10,
        ),
        Tooltip(
          message: "¡Unite a nuestro Discord!",
          child: RichText(
            text: TextSpan(
              text: "Discord",
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Raleway',
                  color: Colors.deepPurple[300],
                  fontWeight: FontWeight.w600),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _launchURL(cfg.get("discordUrl")),
            ),
          ),
        ),
      ],
    );
  }

  Container _getSloganFlutter(BuildContext context) {
    return Container(
      height: 30,
      color: ThemeManager.getDrawerMenuFooterSloganBackgroundColor(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "BUILT WITH 💙 IN ",
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 5,
                  color: Colors.black87,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/general/flutter.png',
              width: 16, height: 16, filterQuality: FilterQuality.high),
        ],
      ),
    );
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Future.delayed(
        Duration(milliseconds: 100),
        () => showToastWidget(
          ToastError(
            padding: EdgeInsets.only(bottom: 100),
          ),
        ),
      );
    }
  }
}
