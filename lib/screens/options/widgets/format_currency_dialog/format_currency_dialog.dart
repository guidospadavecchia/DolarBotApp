import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../../../../classes/settings.dart';
import '../../../../classes/size_config.dart';
import '../../../../classes/theme_manager.dart';
import '../../../../widgets/common/blur_dialog.dart';
import '../../../../widgets/common/simple_button.dart';
import '../../../../widgets/common/toasts/toast_ok.dart';

class FormatCurrencyDialog extends StatefulWidget {
  @override
  _FormatCurrencyDialogState createState() => _FormatCurrencyDialogState();
}

class _FormatCurrencyDialogState extends State<FormatCurrencyDialog> {
  late String _currencyFormat;
  String? _actualCurrencyFormat;

  @override
  Widget build(BuildContext context) {
    final double fontSizeTitle = SizeConfig.blockSizeVertical * 2.3;
    final double fontSizeSubtitle = SizeConfig.blockSizeVertical * 1.8;
    _currencyFormat = Provider.of<Settings>(context, listen: false).getCurrencyFormat();

    if (_actualCurrencyFormat == null) {
      _actualCurrencyFormat = _currencyFormat;
    }

    return BlurDialog(
      dialog: Dialog(
        insetPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
        child: Container(
          width: SizeConfig.screenWidth * 0.8,
          height: SizeConfig.screenHeight * 0.45,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 3,
                  left: SizeConfig.blockSizeHorizontal * 7,
                  right: SizeConfig.blockSizeHorizontal * 7,
                ),
                child: const Text(
                  "Elegí el formato de moneda que aparecerá en todas las cotizaciones:",
                ),
              ),
              Expanded(
                child: SizedBox.shrink(),
              ),
              Container(
                child: RadioListTile<String>(
                  title: Text(
                    'Argentina',
                    style: TextStyle(
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Ejemplo: \$1.234,56',
                    style: TextStyle(
                      fontSize: fontSizeSubtitle,
                    ),
                  ),
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
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              Container(
                child: RadioListTile<String>(
                  title: Text(
                    'Estados Unidos',
                    style: TextStyle(
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Ejemplo: \$1,234.56',
                    style: TextStyle(
                      fontSize: fontSizeSubtitle,
                    ),
                  ),
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
              Expanded(
                child: SizedBox.shrink(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal * 5,
                    right: SizeConfig.blockSizeHorizontal * 5,
                    bottom: SizeConfig.blockSizeVertical * 3,
                  ),
                  child: SimpleButton(
                    text: 'Aplicar',
                    icon: Icons.check_outlined,
                    onPressed: () => saveValueAndPop(_actualCurrencyFormat!),
                  ),
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
