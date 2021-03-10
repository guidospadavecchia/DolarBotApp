import 'package:dolarbot_app/classes/globals.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
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
      appBar: CoolAppBar(
        isMainMenu: false,
        showRefreshButton: false,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
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

  Widget _buildAppInfo() {
    return Column(
      children: [
        Text(
          Globals.packageInfo.appName,
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
          "Versión ${Globals.packageInfo.version}",
          style: _getTextStyle(),
        ),
        SizedBox(
          height: 30,
        ),
        InkWell(
          child: Image.asset(
            'assets/images/logos/border/logo.png',
            scale: 3.0,
            height: 164,
            width: 164,
            filterQuality: FilterQuality.high,
          ),
          onTap: () => _onTapLogo(),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void _onTapLogo() {
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

  Widget _buildDevelopedBy() {
    return Column(
      children: [
        Text(
          "© ${DateTime.now().year}",
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          "Hecho en 🇦🇷 Argentina",
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        Text(
          "Desarrollado por",
          style: _getTextStyle(),
        ),
        SizedBox(height: 15),
        _buildAuthors(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAuthors() {
    List<Widget> authorWidgets = [];
    final authors = cfg.getDeepValue("github:authors");
    for (final author in authors) {
      String name = author["name"];
      String link = author["link"];
      authorWidgets.add(Tooltip(
        message: "Visitar GitHub de $name",
        child: RichText(
          text: TextSpan(
            text: name,
            style: _getTextStyle(isLink: true),
            recognizer: TapGestureRecognizer()
              ..onTap = () => Util.launchURL(link),
          ),
        ),
      ));
      authorWidgets.add(
        SizedBox(height: 5),
      );
    }

    return Column(
      children: authorWidgets,
    );
  }

  Widget _buildSocialMedia() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            "Unite a nuestro Discord, o visitanos en GitHub",
            style: _getTextStyle(),
          ),
          SizedBox(height: 15),
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

  Widget _getSloganFlutter(BuildContext context) {
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
            "HECHO CON 💙 EN ",
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

  TextStyle _getTextStyle({bool isLink = false}) {
    if (isLink) {
      return TextStyle(
        fontSize: 15,
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
