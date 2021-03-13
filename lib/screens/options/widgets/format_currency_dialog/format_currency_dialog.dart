import 'dart:ui';

import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_ok.dart';
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

    return BlurDialog(
      dialog: Dialog(
        insetPadding: EdgeInsets.all(25),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 310,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, right: 7),
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
                activeColor: ThemeManager.getPrimaryAccentColor(context),
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
                activeColor: ThemeManager.getPrimaryAccentColor(context),
                onChanged: (value) {
                  setState(() {
                    _actualCurrencyFormat = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: DialogButton(
                  text: 'Aplicar',
                  icon: Icons.check_outlined,
                  onPressed: () => saveValueAndPop(_actualCurrencyFormat),
                ),
              )
            ],
          ),
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
