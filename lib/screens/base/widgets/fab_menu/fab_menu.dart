import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/classes/globals.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/crypto_calculator.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/crypto_calculator_reversed.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/dialog/fab_option_calculator_dialog.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/fiat_currency_calculator.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/fiat_currency_calculator_reversed.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/metal_calculator.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/metal_calculator_reversed.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/venezuela_calculator.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/calculator/venezuela_calculator_reversed.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:dolarbot_app/widgets/common/simple_fab_menu.dart';
import 'package:dolarbot_app/widgets/toasts/toast_ok.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart' as share2;

class FabMenu extends StatelessWidget {
  final GlobalKey<SimpleFabMenuState> simpleFabKey;
  final bool showFavoriteButton;
  final Function onFavoriteButtonTap;
  final bool showShareButton;
  final Function onShareButtonTap;
  final bool showClipboardButton;
  final bool showCalculatorButton;

  const FabMenu({
    Key key,
    this.simpleFabKey,
    this.showFavoriteButton = true,
    this.onFavoriteButtonTap,
    this.showShareButton = true,
    this.onShareButtonTap,
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
              if (showClipboardButton)
                SimpleFabOption(
                  tooltip: "Copiar al portapapeles 📝",
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
                  tooltip: "Calculadora 💱",
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
              if (showShareButton)
                SimpleFabOption(
                    tooltip: "Compartir cotización 📲",
                    iconColor: Colors.green[700],
                    backgroundColor: Colors.white,
                    icon: Icons.share,
                    onPressed: () {
                      closeFabMenu();
                      onShareButtonTap();
                    }),
              if (showFavoriteButton)
                SimpleFabOption(
                  tooltip: "Agregar a Favoritos ❤",
                  iconColor: Colors.red[300],
                  backgroundColor: Colors.white,
                  icon: Icons.favorite_outline_rounded,
                  onPressed: onFavoriteButtonTap,
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
    share2.Share.share(text, subject: title != null ? 'Cotización $title' : '');
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
            return _getFiatCurrencyCalculatorDialog(
              context,
              activeData,
              decimalSeparator,
              thousandSeparator,
            );
          }

          if (activeData is CryptoResponse) {
            return _getCryptoCalculatorDialog(
              context,
              activeData,
              decimalSeparator,
              thousandSeparator,
            );
          }

          if (activeData is MetalResponse) {
            return _getMetalCalculatorDialog(
              context,
              activeData,
              decimalSeparator,
              thousandSeparator,
            );
          }

          if (activeData is VenezuelaResponse) {
            return _getVenezuelaCalculatorDialog(
              context,
              activeData,
              decimalSeparator,
              thousandSeparator,
            );
          }
        }

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
        arsValue: double.tryParse(data?.arsPrice),
        arsValueWithTaxes: double.tryParse(data?.arsPriceWithTaxes),
        usdValue: double.tryParse(data?.usdPrice),
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

  FabOptionCalculatorDialog _getMetalCalculatorDialog(BuildContext context,
      MetalResponse data, String decimalSeparator, String thousandSeparator) {
    return FabOptionCalculatorDialog(
      calculator: MetalCalculator(
        usdValue: double.tryParse(data?.value),
        unit: data?.unit,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
      calculatorReversed: MetalCalculatorReversed(
        usdValue: double.tryParse(data?.value),
        unit: data?.unit,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
    );
  }

  FabOptionCalculatorDialog _getVenezuelaCalculatorDialog(
      BuildContext context,
      VenezuelaResponse data,
      String decimalSeparator,
      String thousandSeparator) {
    return FabOptionCalculatorDialog(
      calculator: VenezuelaCalculator(
        bankValue: double.tryParse(data?.bankPrice),
        blackMarketValue: double.tryParse(data?.blackMarketPrice),
        symbol: Util.getFiatCurrencySymbol(data),
        currencyCode: data?.currencyCode,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
      calculatorReversed: VenezuelaCalculatorReversed(
        bankValue: double.tryParse(data?.bankPrice),
        blackMarketValue: double.tryParse(data?.blackMarketPrice),
        symbol: Util.getFiatCurrencySymbol(data),
        currencyCode: data?.currencyCode,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
    );
  }
}
