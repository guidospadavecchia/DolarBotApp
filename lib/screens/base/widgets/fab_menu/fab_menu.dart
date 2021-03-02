import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/classes/globals.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/crypto_calculator.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/crypto_calculator_reversed.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/dialog/fab_option_calculator_dialog.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/fiat_currency_calculator.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/fiat_currency_calculator_reversed.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:dolarbot_app/widgets/common/simple_fab_menu.dart';
import 'package:dolarbot_app/widgets/toasts/toast_ok.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class FabMenu extends StatelessWidget {
  final GlobalKey<SimpleFabMenuState> simpleFabKey;
  final bool showFavoriteButton;
  final bool showShareButton;
  final bool showClipboardButton;
  final bool showCalculatorButton;

  const FabMenu({
    Key key,
    this.simpleFabKey,
    this.showFavoriteButton = true,
    this.showShareButton = true,
    this.showClipboardButton = true,
    this.showCalculatorButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(builder: (context, settings, child) {
      return Consumer<ActiveScreenData>(builder: (context, activeData, child) {
        if (!Globals.dataIsLoading) {
          return SimpleFabMenu(
            key: simpleFabKey,
            direction: Axis.horizontal,
            icon: Icons.more_horiz,
            iconColor: Colors.black87,
            backGroundColor: Colors.white,
            items: <SimpleFabOption>[
              if (showFavoriteButton)
                SimpleFabOption(
                  tooltip: "¡Agregar a Favoritos!",
                  iconColor: Colors.black87,
                  backgroundColor: Colors.white,
                  icon: Icons.favorite_rounded,
                  onPressed: () => {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 3),
                      content: Text("Falta agregar funcionalidad 🪁"),
                    ))
                  },
                ),
              if (showShareButton)
                SimpleFabOption(
                  tooltip: "Compartir",
                  iconColor: Colors.black87,
                  backgroundColor: Colors.white,
                  icon: Icons.share,
                  onPressed: () => share(
                    activeData.getShareData(),
                    title: activeData.getActiveTitle(),
                  ),
                ),
              if (showClipboardButton)
                SimpleFabOption(
                  tooltip: "Copiar al portapapeles",
                  iconColor: Colors.black87,
                  backgroundColor: Colors.white,
                  icon: Icons.copy,
                  onPressed: () async => await copyToClipboard(
                    context,
                    activeData.getShareData(),
                  ),
                ),
              if (showCalculatorButton)
                SimpleFabOption(
                  tooltip: "Calculadora",
                  iconColor: Colors.black87,
                  backgroundColor: Colors.white,
                  icon: FontAwesomeIcons.calculator,
                  onPressed: () {
                    openCalculator(
                      context,
                      activeData.getActiveData(),
                    );
                  },
                ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      });
    });
  }

  void closeFabMenu() {
    if (simpleFabKey?.currentState?.isOpen ?? false) {
      simpleFabKey.currentState.closeMenu();
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
