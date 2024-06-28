import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../classes/app_config.dart';
import '../../classes/size_config.dart';
import '../../util/util.dart';
import '../../widgets/about/special_thanks_dialog.dart';
import '../../widgets/common/blur_dialog.dart';
import '../../widgets/common/cool_app_bar.dart';
import '../../widgets/common/social/discord.dart';
import '../../widgets/common/social/github.dart';

class AboutScreen extends StatefulWidget {
  static const String routeName = '/about';

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            // height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.teal[900]!,
                  Colors.blueGrey[900]!,
                ],
              ),
              image: const DecorationImage(image: AssetImage("assets/images/general/about.png"), fit: BoxFit.cover),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAppInfo(),
              _buildDevelopedBy(),
              _buildSocialMedia(),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _getSloganFlutter(context),
    );
  }

  Widget _buildAppInfo() {
    return Column(
      children: [
        Text(
          AppConfig.appDisplayName,
          style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 4.5,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            color: Colors.white,
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
        Text(
          "Versión ${AppConfig.of(context).version}",
          style: _getTextStyle(),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 3),
        InkWell(
          child: Image.asset(
            AppConfig.logo.border,
            scale: 3.0,
            height: SizeConfig.screenHeight / 5,
            width: SizeConfig.screenHeight / 5,
            filterQuality: FilterQuality.high,
          ),
          onTap: () => _onTapLogo(),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 3,
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
          "Hecho en 🇦🇷 Argentina",
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical),
        Text(
          "© ${DateTime.now().year} ArrowBlade Software",
          style: _getTextStyle(),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1.5),
        _buildSpecialThanks(),
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
    final authors = Util.cfg.getDeepValue("github:authors");
    for (final author in authors) {
      String? name = author["name"];
      String? link = author["link"];
      if (name != null && link != null) {
        authorWidgets.add(
          Tooltip(
            message: "Visitar GitHub de $name",
            child: RichText(
              text: TextSpan(
                text: name,
                style: _getTextStyle(isLink: true),
                recognizer: TapGestureRecognizer()..onTap = () => Util.launchURL(link),
              ),
            ),
          ),
        );
        authorWidgets.add(
          SizedBox(height: SizeConfig.blockSizeVertical * 1.2),
        );
      }
    }

    return Column(
      children: authorWidgets,
    );
  }

  Widget _buildSpecialThanks() {
    final List<dynamic>? specialThanksNames = Util.cfg.getDeepValue("specialThanks");
    if (specialThanksNames != null && specialThanksNames.length > 0) {
      List<String> names = specialThanksNames.map((x) => x.toString()).toList();
      return Tooltip(
        message: "Ver agradecimientos",
        child: RichText(
          text: TextSpan(
            text: "Agradecimientos",
            style: _getTextStyle(isLink: true),
            recognizer: TapGestureRecognizer()
              ..onTap = () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SpecialThanksDialog(
                        names: names,
                      );
                    },
                  ),
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
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
              Discord(imageSize: SizeConfig.blockSizeVertical * 4, fontSize: SizeConfig.blockSizeVertical * 2.3),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
              GitHub(imageSize: SizeConfig.blockSizeVertical * 4, fontSize: SizeConfig.blockSizeVertical * 2.3, color: Colors.white70),
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
              width: SizeConfig.blockSizeVertical * 2, height: SizeConfig.blockSizeVertical * 2, filterQuality: FilterQuality.high),
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
