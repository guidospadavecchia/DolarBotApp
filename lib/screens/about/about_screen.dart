import 'package:dolarbot_app/classes/app_config.dart';
import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
import 'package:dolarbot_app/widgets/common/social/discord.dart';
import 'package:dolarbot_app/widgets/common/social/github.dart';
import 'package:dolarbot_app/widgets/common/pills/pill.dart';
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
              Colors.teal[900]!,
              Colors.blueGrey[900]!,
            ],
          ),
          image: const DecorationImage(
              image: AssetImage("assets/images/general/about.png"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAppInfo(),
              _buildDevelopedBy(),
              _buildSocialMedia(),
              SizedBox(height: SizeConfig.blockSizeVertical * 6),
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
          AppConfig.of(context).appDisplayName,
          style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 4.5,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2,
        ),
        Pill(
          text: AppConfig.of(context).getFlavorValue(),
          fontSize: 11,
          padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical / 2),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical,
        ),
        Text(
          "Versión ${AppConfig.of(context).version}",
          style: _getTextStyle(),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
        ),
        InkWell(
          child: Image.asset(
            AppConfig.of(context).logo.border,
            scale: 3.0,
            height: SizeConfig.screenHeight / 5,
            width: SizeConfig.screenHeight / 5,
            filterQuality: FilterQuality.high,
          ),
          onTap: () => _onTapLogo(),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 4,
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
            return BlurDialog(
              dialog: Dialog(
                child: Container(
                  child: Image.asset(
                    "assets/images/general/authors.jpg",
                    fit: BoxFit.scaleDown,
                    filterQuality: FilterQuality.high,
                  ),
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
          "Hecho en 🇦🇷 Argentina - © ${DateTime.now().year}",
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 4),
        Text(
          "Desarrollado por",
          style: _getTextStyle(),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
        _buildAuthors(),
      ],
    );
  }

  Widget _buildAuthors() {
    final List<Widget> authorWidgets = [];
    final authors = cfg.getDeepValue("github:authors");
    for (final author in authors) {
      String? name = author["name"];
      String? link = author["link"];
      if (name != null && link != null) {
        authorWidgets.add(Tooltip(
          message: "Visitar GitHub de $name",
          child: RichText(
            text: TextSpan(
              text: name,
              style: _getTextStyle(isLink: true),
              recognizer: TapGestureRecognizer()..onTap = () => Util.launchURL(link),
            ),
          ),
        ));
        authorWidgets.add(
          SizedBox(height: SizeConfig.blockSizeVertical * 1.2),
        );
      }
    }

    return Column(
      children: authorWidgets,
    );
  }

  Widget _buildSocialMedia() {
    return Padding(
      padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
      child: Column(
        children: [
          Text(
            "Unite a nuestro Discord, o visitanos en GitHub",
            style: _getTextStyle(),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2.5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Discord(
                  imageSize: SizeConfig.blockSizeVertical * 4,
                  fontSize: SizeConfig.blockSizeVertical * 2.3),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
              GitHub(
                  imageSize: SizeConfig.blockSizeVertical * 4,
                  fontSize: SizeConfig.blockSizeVertical * 2.3,
                  color: Colors.white70),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getSloganFlutter(BuildContext context) {
    return Container(
      height: SizeConfig.blockSizeVertical * 5,
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        border: Border.all(color: Colors.blueGrey[800]!, width: 0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "HECHO CON 💙 EN ",
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 1.8,
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
              width: SizeConfig.blockSizeVertical * 2,
              height: SizeConfig.blockSizeVertical * 2,
              filterQuality: FilterQuality.high),
        ],
      ),
    );
  }

  TextStyle _getTextStyle({bool isLink = false}) {
    if (isLink) {
      return TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 2,
        fontWeight: FontWeight.w600,
        fontFamily: 'Raleway',
        color: Colors.teal[200],
      );
    } else {
      return TextStyle(
        fontSize: SizeConfig.blockSizeVertical * 1.7,
        fontWeight: FontWeight.normal,
        fontFamily: 'Raleway',
        color: Colors.white,
      );
    }
  }
}
