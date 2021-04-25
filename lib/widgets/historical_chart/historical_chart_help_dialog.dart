import 'dart:ui';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/simple_button.dart';
import 'package:flutter/material.dart';

class HistoricalChartHelpDialog extends StatelessWidget {
  static const String _kDescriptionText =
      "Este gráfico te permite visualizar la evolución histórica de las distintas cotizaciones. Dicha información se recolecta periódicamente y de forma local, a partir de tus consultas dentro de la app.\n\nRecordá que podes limpiar los datos de las cotizaciones guardadas, en cualquier momento, desde el menú de Opciones.";

  const HistoricalChartHelpDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurDialog(
      dialog: Dialog(
        insetPadding: const EdgeInsets.all(25),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "¿Qué es esto?",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: ThemeManager.getPrimaryTextColor(context),
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: 15,
                endIndent: 15,
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Text(_kDescriptionText, textAlign: TextAlign.justify),
              ),
              Center(
                child: SimpleButton(
                  text: 'Entendido',
                  icon: Icons.check,
                  onPressed: () {
                    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
