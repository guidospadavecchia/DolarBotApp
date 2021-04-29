import 'dart:ui';

import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/simple_button.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_ok.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class FabDirectionDialog extends StatefulWidget {
  @override
  _FabDirectionDialogState createState() => _FabDirectionDialogState();
}

class _FabDirectionDialogState extends State<FabDirectionDialog> {
  Axis _fabDirection;
  Axis _actualFabDirection;

  @override
  Widget build(BuildContext context) {
    _fabDirection = Provider.of<Settings>(context, listen: false).getFabDirection();

    if (_actualFabDirection == null) {
      _actualFabDirection = _fabDirection;
    }

    return BlurDialog(
      dialog: Dialog(
        insetPadding: const EdgeInsets.all(25),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 320,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: const Text(
                    "Elegí la dirección en la que se desplegará el menú de acciones en las pantallas de cotización:"),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 280,
                child: RadioListTile<Axis>(
                  title: const Text(
                    'Vertical',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text('Despliegue hacia arriba.'),
                  value: Axis.vertical,
                  groupValue: _actualFabDirection,
                  activeColor: ThemeManager.getPrimaryAccentColor(context),
                  onChanged: (value) {
                    setState(() {
                      _actualFabDirection = value;
                    });
                  },
                ),
              ),
              Container(
                width: 280,
                child: RadioListTile<Axis>(
                  title: Text(
                    'Horizontal',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text('Despliegue hacia la izquierda.'),
                  value: Axis.horizontal,
                  groupValue: _actualFabDirection,
                  activeColor: ThemeManager.getPrimaryAccentColor(context),
                  onChanged: (value) {
                    setState(() {
                      _actualFabDirection = value;
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
                  onPressed: () => saveValueAndPop(_actualFabDirection),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveValueAndPop(Axis value) async {
    Provider.of<Settings>(context, listen: false).saveFabDirection(value);
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
