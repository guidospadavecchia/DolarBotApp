import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/social/discord.dart';
import 'package:dolarbot_app/widgets/common/social/github.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class AboutScreen extends StatelessWidget {
  static const String routeName = '/about';
  final cfg = GlobalConfiguration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.teal[900],
                Colors.blueGrey[900],
              ]),
          image: DecorationImage(
              image: AssetImage("assets/images/general/about.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildAppInfo(),
            _buildDevelopedBy(),
            _buildSocialMedia(),
          ],
        ),
      ),
      bottomNavigationBar: _getSloganFlutter(context),
    );
  }

  _buildSocialMedia() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text("Unite a nuestro Discord, o visitanos en GitHub.",
              style: _getTextStyle()),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Discord(imageSize: 32, fontSize: 18),
              SizedBox(width: 30),
              GitHub(imageSize: 32, fontSize: 18, color: Colors.white70),
            ],
          ),
        ],
      ),
    );
  }

  _buildAppInfo() {
    return Column(
      children: [
        Text(
          "DolarBot",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "Versión 1.0.0",
          style: _getTextStyle(),
        ),
        SizedBox(
          height: 20,
        ),
        Image.asset(
          'assets/images/logos/border/logo.png',
          scale: 3.0,
          height: 164,
          width: 164,
          filterQuality: FilterQuality.high,
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _buildDevelopedBy() {
    return Column(
      children: [
        Text(
          "© 2021\nHecho en 🇦🇷 Argentina.",
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Desarrollado por ",
              style: _getTextStyle(),
            ),
            Tooltip(
              message: "Visitar GitHub de Guido Spadavecchia",
              child: RichText(
                text: TextSpan(
                  text: "Guido Spadavecchia",
                  style: _getTextStyle(isLink: true),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Util.launchURL(cfg.getDeepValue("github:gs")),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " y ",
              style: _getTextStyle(),
            ),
            Tooltip(
              message: "Visitar GitHub de Juan Manuel Flecha",
              child: RichText(
                text: TextSpan(
                  text: "Juan Manuel Flecha",
                  style: _getTextStyle(isLink: true),
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Util.launchURL(cfg.getDeepValue("github:jmf")),
                ),
              ),
            ),
            Text(
              ".",
              style: _getTextStyle(),
            ),
          ],
        ),
        SizedBox(height: 25),
      ],
    );
  }

  _getSloganFlutter(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        border: Border.all(color: Colors.blueGrey[800], width: 0),
      ),
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

  _getTextStyle({bool isLink = false}) {
    if (isLink) {
      return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Raleway',
        color: Colors.teal[200],
      );
    } else {
      return TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        fontFamily: 'Raleway',
        color: Colors.white,
      );
    }
  }
}
