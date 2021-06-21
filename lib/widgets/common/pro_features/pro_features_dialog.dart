import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:dolarbot_app/classes/app_config.dart';
import 'package:dolarbot_app/classes/dolarbot_icons.dart';
import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/pills/pro_pill.dart';
import 'package:dolarbot_app/widgets/common/rich_text_span/rich_text_span.dart';
import 'package:dolarbot_app/widgets/drawer/drawer_menu_body.dart';
import 'package:flutter/material.dart';

class ProFeaturesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlurDialog(
      dialog: Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          width: SizeConfig.screenWidth / 1.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(context),
              _buildBody(context),
              _buildFooter(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Image.asset(
                  AppConfig.logo.borderless,
                  scale: 3.0,
                  height: 48,
                  width: 48,
                  filterQuality: FilterQuality.high,
                ),
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 15),
              Row(
                children: [
                  const Text(
                    'Dolar',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        letterSpacing: 0.5),
                  ),
                  Text(
                    'Bot',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Raleway',
                        color: ThemeManager.getPrimaryColor(),
                        letterSpacing: 0.5),
                  ),
                  const SizedBox(width: 15),
                  ProPill(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            endIndent: 0,
            indent: 0,
            color: ThemeManager.getDividerColor(context),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
        ],
      ),
    );
  }

  _buildBody(BuildContext context) {
    double fontSize = SizeConfig.blockSizeHorizontal * 4.2;

    return Container(
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                RichTextSpan.text(context,
                    "Accedé a las las cotizaciones del dólar, euro y real de la mayoría de los",
                    fontSize: fontSize),
                RichTextSpan.text(context, " Bancos Argentinos", bold: true, fontSize: fontSize),
                RichTextSpan.text(context, ",", fontSize: fontSize),
              ],
            ),
          ),
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(20),
              child: Opacity(
                opacity: 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getIconAsset(context, DolarBotIcons.banks.bbva),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.banks.hipotecario),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.banks.galicia),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.banks.nacion),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.banks.santander),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.banks.supervielle),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.banks.comafi),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.banks.patagonia),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.banks.ciudad),
                    const SizedBox(width: 10),
                    Text(
                      "¡Y más!",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                RichTextSpan.text(context, "a las", fontSize: fontSize),
                RichTextSpan.text(context, " Cryptos ", bold: true, fontSize: fontSize),
                RichTextSpan.text(context, "más conocidas,", fontSize: fontSize),
              ],
            ),
          ),
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(20),
              child: Opacity(
                opacity: 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    getIconData(context, CryptoFontIcons.BTC!),
                    const SizedBox(width: 10),
                    getIconData(context, CryptoFontIcons.ETH!),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.crypto.dai),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.crypto.binance),
                    const SizedBox(width: 10),
                    getIconData(context, CryptoFontIcons.BTC_ALT!),
                    const SizedBox(width: 10),
                    getIconData(context, CryptoFontIcons.LTC!),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.crypto.cardano),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.crypto.chainlink),
                    const SizedBox(width: 10),
                    getIconAsset(context, DolarBotIcons.crypto.stellar),
                    const SizedBox(width: 10),
                    Text(
                      "¡Y más!",
                      style: TextStyle(fontFamily: "Roboto", fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                RichTextSpan.text(context, "gráficos de evolución histórica, y mucho más.",
                    fontSize: fontSize),
                RichTextSpan.newLine(context),
                RichTextSpan.newLine(context),
                RichTextSpan.text(
                    context, "Todo esto, sin anuncios, y por menos de lo que cuesta un café",
                    fontSize: fontSize),
                RichTextSpan.text(context, " ☕", fontSize: 20),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 3),
          Theme(
            data: Theme.of(context)
                .copyWith(splashColor: Colors.white24, highlightColor: Colors.white10),
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "assets/images/general/google-play-badge.png",
                  scale: 2.5,
                  filterQuality: FilterQuality.high,
                ),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Util.launchURL(Util.cfg.getDeepValue<String>("playStoreUrls:pro")!);
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
        ],
      ),
    );
  }

  _buildFooter(BuildContext context) {
    return Column(
      children: [
        Divider(
          endIndent: 0,
          indent: 0,
          color: ThemeManager.getDividerColor(context),
        ),
        const SizedBox(height: 10),
        Text(
          "Google Play y el logo de Google Play son marcas registradas de Google LLC.",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
