import 'dart:ui';

import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/classes/settings.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/simple_button.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_ok.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class FormatCurrencyDialog extends StatefulWidget {
  @override
  _FormatCurrencyDialogState createState() => _FormatCurrencyDialogState();
}

class _FormatCurrencyDialogState extends State<FormatCurrencyDialog> {
  late String _currencyFormat;
  String? _actualCurrencyFormat;

  @override
  Widget build(BuildContext context) {
    _currencyFormat = Provider.of<Settings>(context, listen: false).getCurrencyFormat();

    if (_actualCurrencyFormat == null) {
      _actualCurrencyFormat = _currencyFormat;
    }

    return BlurDialog(
      dialog: Dialog(
        insetPadding: const EdgeInsets.all(25),
        child: Container(
          width: SizeConfig.screenWidth * 0.8,
          height: 310,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: const Text(
                    "Elegí el formato de moneda que aparecerá en todas las cotizaciones:"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 230,
                child: RadioListTile<String>(
                  title: const Text(
                    'Argentina',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text('Ejemplo: \$1.234,56'),
                  value: CurrencyFormats.AR.value,
                  groupValue: _actualCurrencyFormat,
                  activeColor: ThemeManager.getPrimaryAccentColor(context),
                  onChanged: (value) {
                    setState(() {
                      _actualCurrencyFormat = value;
                    });
                  },
                ),
              ),
              Container(
                width: 230,
                child: RadioListTile<String>(
                  title: const Text(
                    'Estados Unidos',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text('Ejemplo: \$1,234.56'),
                  value: CurrencyFormats.US.value,
                  groupValue: _actualCurrencyFormat,
                  activeColor: ThemeManager.getPrimaryAccentColor(context),
                  onChanged: (value) {
                    setState(() {
                      _actualCurrencyFormat = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SimpleButton(
                  text: 'Aplicar',
                  icon: Icons.check_outlined,
                  onPressed: () => saveValueAndPop(_actualCurrencyFormat!),
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
    await Future.delayed(const Duration(milliseconds: 50))
        .then(
          (value) => Navigator.of(context).pop(),
        )
        .then(
          (_) async => {
            Future.delayed(
              const Duration(milliseconds: 100),
              () => showToastWidget(
                ToastOk(),
              ),
            ),
          },
        );
  }
}
