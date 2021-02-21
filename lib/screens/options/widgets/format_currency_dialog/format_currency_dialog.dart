import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormatCurrencyDialog extends StatefulWidget {
  @override
  _FormatCurrencyDialogState createState() => _FormatCurrencyDialogState();
}

class _FormatCurrencyDialogState extends State<FormatCurrencyDialog> {
  String _currencyFormat;

  @override
  Widget build(BuildContext context) {
    _currencyFormat =
        Provider.of<Settings>(context, listen: false).getCurrencyFormat();

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
              groupValue: _currencyFormat,
              activeColor: ThemeManager.getGlobalAccentColor(context),
              onChanged: (value) {
                setState(() {
                  saveValueAndPop(value);
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
              groupValue: _currencyFormat,
              activeColor: ThemeManager.getGlobalAccentColor(context),
              onChanged: (value) {
                setState(() {
                  saveValueAndPop(value);
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            DialogButton(
              text: 'Aceptar',
              icon: Icons.check_outlined,
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }

  void saveValueAndPop(String value) async {
    _currencyFormat = value;
    Provider.of<Settings>(context, listen: false).saveCurrencyFormat(value);
  }
}
