import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
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
        width: 300,
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
          children: [
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
          ],
        ),
      ),
    );
  }

  void saveValueAndPop(String value) async {
    _currencyFormat = value;
    Provider.of<Settings>(context, listen: false).saveCurrencyFormat(value);
    await Future.delayed(Duration(milliseconds: 50)).then(
      (value) => Navigator.of(context).pop(),
    );
  }
}
