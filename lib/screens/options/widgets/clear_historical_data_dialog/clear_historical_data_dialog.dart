import '../../../../classes/size_config.dart';
import '../../../../widgets/common/blur_dialog.dart';
import '../../../../widgets/common/simple_button.dart';
import '../../../../widgets/common/toasts/toast_ok.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:oktoast/oktoast.dart';

class ClearHistoricalDataDialog extends StatefulWidget {
  @override
  _ClearHistoricalDataDialogState createState() => _ClearHistoricalDataDialogState();
}

class _ClearHistoricalDataDialogState extends State<ClearHistoricalDataDialog> {
  @override
  Widget build(BuildContext context) {
    return BlurDialog(
      dialog: Dialog(
        insetPadding: EdgeInsets.all(
          SizeConfig.blockSizeVertical * 3,
        ),
        child: Container(
          width: SizeConfig.screenWidth * 0.8,
          height: SizeConfig.screenHeight * 0.35,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 7,
                  vertical: SizeConfig.blockSizeVertical * 3,
                ),
                child: const Text(
                  "Al limpiar los datos de las cotizaciones, dejará de mostrarse la información guardada relativa a los gráficos históricos.",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 7),
                child: const Text(
                  "¿Estás seguro que deseas continuar?",
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: SizedBox.shrink(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 7,
                    vertical: SizeConfig.blockSizeVertical * 3,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SimpleButton(
                        text: 'Sí, eliminar',
                        icon: Icons.delete,
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        onPressed: () => clearData(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void clearData() async {
    Box historicalRatesBox = Hive.box('historicalRates');
    historicalRatesBox.clear().then((_) => Navigator.of(context).pop()).then((_) async => {
          Future.delayed(
            const Duration(milliseconds: 100),
            () => showToastWidget(
              ToastOk(),
            ),
          ),
        });
  }
}
