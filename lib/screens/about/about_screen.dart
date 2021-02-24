import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/social/discord.dart';
import 'package:dolarbot_app/widgets/common/social/github.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';

class AboutScreen extends StatefulWidget {
  static const String routeName = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final cfg = GlobalConfiguration();
  int tapCount = 0;

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
        child: Padding(
          padding: const EdgeInsets.only(top: 70),
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
      ),
      bottomNavigationBar: _getSloganFlutter(context),
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
        InkWell(
          child: Image.asset(
            'assets/images/logos/border/logo.png',
            scale: 3.0,
            height: 164,
            width: 164,
            filterQuality: FilterQuality.high,
          ),
          onTap: () {
            _onTapLogo();
          },
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  _onTapLogo() {
    setState(() {
      tapCount += 1;
      if (tapCount == 5) {
        tapCount = 0;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(
                child: Image.asset(
                  "assets/images/general/authors.jpg",
                  filterQuality: FilterQuality.high,
                ),
              ),
            );
          },
        );
      }
    });
  }

  _buildDevelopedBy() {
    return Column(
      children: [
        Text(
          "© 2021\nHecho en 🇦🇷 Argentina.",
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        Text(
          "Desarrollado por",
          style: _getTextStyle(),
        ),
        SizedBox(height: 15),
        Tooltip(
          message: "Visitar GitHub de Guido Spadavecchia",
          child: RichText(
            text: TextSpan(
              text: "Guido Spadavecchia",
              style: _getTextStyle(isLink: true),
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => Util.launchURL(cfg.getDeepValue("github:authors")[0]),
            ),
          ),
        ),
        SizedBox(height: 5),
        Tooltip(
          message: "Visitar GitHub de Juan Manuel Flecha",
          child: RichText(
            text: TextSpan(
              text: "Juan Manuel Flecha",
              style: _getTextStyle(isLink: true),
              recognizer: TapGestureRecognizer()
                ..onTap =
                    () => Util.launchURL(cfg.getDeepValue("github:authors")[1]),
            ),
          ),
        ),
        SizedBox(height: 25),
      ],
    );
  }

  _buildSocialMedia() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        children: [
          Text(
            "Unite a nuestro Discord, o visitanos en GitHub.",
            style: _getTextStyle(),
          ),
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

  _getSloganFlutter(BuildContext context) {
    return Container(
      height: 40,
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
              fontSize: 14,
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