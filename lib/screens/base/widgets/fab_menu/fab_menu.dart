import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/classes/globals.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/crypto_calculator.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/crypto_calculator_reversed.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/dialog/fab_option_calculator_dialog.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/fiat_currency_calculator.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/fiat_currency_calculator_reversed.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/fab_menu_option.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:dolarbot_app/widgets/toasts/toast_ok.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class FabMenu extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey;
  final bool showShareButton;
  final bool showClipboardButton;
  final bool showCalculatorButton;

  const FabMenu({
    Key key,
    this.fabKey,
    this.showShareButton = true,
    this.showClipboardButton = true,
    this.showCalculatorButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(builder: (context, settings, child) {
      return Consumer<ActiveScreenData>(builder: (context, activeData, child) {
        if (!Globals.dataIsLoading) {
          return Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: FabCircularMenu(
              key: fabKey,
              alignment: Alignment.bottomRight,
              fabColor: ThemeManager.getForegroundColor(),
              fabOpenIcon: Icon(
                Icons.more_horiz,
                color: Colors.black87,
              ),
              fabCloseIcon: Icon(
                Icons.close,
                color: Colors.black87,
              ),
              fabMargin: EdgeInsets.only(bottom: 20, right: 20),
              fabSize: 64,
              ringColor: Colors.transparent,
              ringDiameter: MediaQuery.of(context).size.width * 0.7,
              fabElevation: 10,
              animationDuration: Duration(milliseconds: 600),
              animationCurve: Curves.easeInOutCirc,
              children: [
                FabMenuOption(
                  icon: Icons.share,
                  onTap: () => share(
                    activeData.getShareData(),
                    title: activeData.getActiveTitle(),
                  ),
                ),
                if (showClipboardButton)
                  FabMenuOption(
                    icon: Icons.copy,
                    onTap: () async => await copyToClipboard(
                      context,
                      activeData.getShareData(),
                    ),
                  ),
                if (showCalculatorButton)
                  FabMenuOption(
                    icon: FontAwesomeIcons.calculator,
                    onTap: () {
                      openCalculator(
                        context,
                        activeData.getActiveData(),
                      );
                    },
                  ),
              ],
            ),
          );
        } else {
          return Container();
        }
      });
    });
  }

  void closeFabMenu() {
    if (fabKey?.currentState?.isOpen ?? false) {
      fabKey.currentState.close();
    }
  }

  void share(String text, {String title}) {
    Share.share(text, subject: title != null ? 'Cotización $title' : '');
    closeFabMenu();
  }

  Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(
      new ClipboardData(
        text: text,
      ),
    )
        .then(
          (_) => closeFabMenu(),
        )
        .then(
          (_) async => {
            Future.delayed(
              Duration(milliseconds: 100),
              () => showToastWidget(
                ToastOk(),
              ),
            ),
          },
        );
  }

  void openCalculator(BuildContext context, ApiResponse activeData) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        if (activeData != null) {
          String _currencyFormat =
              Provider.of<Settings>(context, listen: false).getCurrencyFormat();
          String decimalSeparator = _currencyFormat == "es_AR" ? "," : ".";
          String thousandSeparator = _currencyFormat == "es_AR" ? "." : ",";

          if (activeData is GenericCurrencyResponse) {
            GenericCurrencyResponse data = activeData;
            return _getFiatCurrencyCalculatorDialog(
              context,
              data,
              decimalSeparator,
              thousandSeparator,
            );
          }

          if (activeData is CryptoResponse) {
            CryptoResponse data = activeData;
            return _getCryptoCalculatorDialog(
              context,
              data,
              decimalSeparator,
              thousandSeparator,
            );
          }
        }

        //TODO Metals & Venezuela calculator

        return _getNotSupportedDialog(context);
      },
    );
    closeFabMenu();
  }

  Dialog _getNotSupportedDialog(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 150,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Opción no soportada',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
              ),
            ),
            DialogButton(
              icon: Icons.close,
              text: "Cerrar",
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  FabOptionCalculatorDialog _getFiatCurrencyCalculatorDialog(
      BuildContext context,
      GenericCurrencyResponse data,
      String decimalSeparator,
      String thousandSeparator) {
    return FabOptionCalculatorDialog(
      calculator: FiatCurrencyCalculator(
        buyValue: double.tryParse(data?.buyPrice ?? ''),
        sellValue: double.tryParse(data?.sellPrice ?? ''),
        sellValueWithTaxes: double.tryParse(data?.sellPriceWithTaxes ?? ''),
        symbol: Util.getFiatCurrencySymbol(data),
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
      calculatorReversed: FiatCurrencyCalculatorReversed(
        sellValue: data?.sellPriceWithTaxes == null
            ? double.tryParse(data?.sellPrice ?? '')
            : null,
        sellValueWithTaxes: double.tryParse(data?.sellPriceWithTaxes ?? ''),
        symbol: Util.getFiatCurrencySymbol(data),
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
    );
  }

  FabOptionCalculatorDialog _getCryptoCalculatorDialog(BuildContext context,
      CryptoResponse data, String decimalSeparator, String thousandSeparator) {
    return FabOptionCalculatorDialog(
      calculator: CryptoCalculator(
        arsValue: double.tryParse(data?.arsPrice ?? ''),
        arsValueWithTaxes: double.tryParse(data?.arsPriceWithTaxes ?? ''),
        usdValue: double.tryParse(data?.usdPrice ?? ''),
        cryptoCode: data.code,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
      calculatorReversed: CryptoCalculatorReversed(
        usdValue: double.tryParse(data?.usdPrice ?? ''),
        cryptoCode: data.code,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
    );
  }
}
