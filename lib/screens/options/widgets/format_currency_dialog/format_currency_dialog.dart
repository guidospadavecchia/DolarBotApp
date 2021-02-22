import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:dolarbot_app/widgets/toasts/toast_ok.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class FormatCurrencyDialog extends StatefulWidget {
  @override
  _FormatCurrencyDialogState createState() => _FormatCurrencyDialogState();
}

class _FormatCurrencyDialogState extends State<FormatCurrencyDialog> {
  String _currencyFormat;
  String _actualCurrencyFormat;

  @override
  Widget build(BuildContext context) {
    _currencyFormat =
        Provider.of<Settings>(context, listen: false).getCurrencyFormat();

    if (_actualCurrencyFormat == null) {
      _actualCurrencyFormat = _currencyFormat;
    }

    return Dialog(
      insetPadding: EdgeInsets.all(25),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 310,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10, width: 2),
          gradient: AdaptiveTheme.of(context).brightness == Brightness.dark
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(14, 24, 29, 1),
                    Color.fromRGBO(14, 24, 29, 0.4)
                  ],
                )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 7),
              child: Text(
                  "Elegí el formato de moneda que\naparecerá en todas las cotizaciones."),
            ),
            SizedBox(
              height: 10,
            ),
            RadioListTile<String>(
              title: Text(
                'Argentina',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text('Ejemplo: \$1.234,56'),
              value: "es_AR",
              groupValue: _actualCurrencyFormat,
              activeColor: ThemeManager.getGlobalAccentColor(context),
              onChanged: (value) {
                setState(() {
                  _actualCurrencyFormat = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text(
                'Estados Unidos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text('Ejemplo: \$1,234.56'),
              value: "en_US",
              groupValue: _actualCurrencyFormat,
              activeColor: ThemeManager.getGlobalAccentColor(context),
              onChanged: (value) {
                setState(() {
                  _actualCurrencyFormat = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            DialogButton(
              text: 'Aplicar',
              icon: Icons.check_outlined,
              onPressed: () => saveValueAndPop(_actualCurrencyFormat),
            )
          ],
        ),
      ),
    );
  }

  void saveValueAndPop(String value) async {
    Provider.of<Settings>(context, listen: false).saveCurrencyFormat(value);
    await Future.delayed(Duration(milliseconds: 50))
        .then(
          (value) => Navigator.of(context).pop(),
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
}
