import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/simple_button.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_ok.dart';
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
        insetPadding: const EdgeInsets.all(25),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: 230,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: const Text(
                  "Al limpiar los datos de las cotizaciones, dejará de mostrarse la información guardada relativa a los gráficos históricos.",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: const Text(
                  "¿Estás seguro que deseas continuar?",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
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
