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

class FabDirectionDialog extends StatefulWidget {
  @override
  _FabDirectionDialogState createState() => _FabDirectionDialogState();
}

class _FabDirectionDialogState extends State<FabDirectionDialog> {
  late Axis _fabDirection;
  Axis? _actualFabDirection;

  @override
  Widget build(BuildContext context) {
    final double fontSizeTitle = SizeConfig.blockSizeVertical * 2.3;
    final double fontSizeSubtitle = SizeConfig.blockSizeVertical * 1.8;
    _fabDirection = Provider.of<Settings>(context, listen: false).getFabDirection();

    if (_actualFabDirection == null) {
      _actualFabDirection = _fabDirection;
    }

    return BlurDialog(
      dialog: Dialog(
        insetPadding: EdgeInsets.all(
          SizeConfig.blockSizeVertical * 3,
        ),
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
                  "Elegí la dirección en la que se desplegará el menú de acciones en las pantallas de cotización:",
                ),
              ),
              Expanded(
                child: SizedBox.shrink(),
              ),
              Container(
                child: RadioListTile<Axis>(
                  title: Text(
                    'Vertical',
                    style: TextStyle(
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Despliegue hacia arriba.',
                    style: TextStyle(
                      fontSize: fontSizeSubtitle,
                    ),
                  ),
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
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              Container(
                child: RadioListTile<Axis>(
                  title: Text(
                    'Horizontal',
                    style: TextStyle(
                      fontSize: fontSizeTitle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    'Despliegue hacia la izquierda.',
                    style: TextStyle(
                      fontSize: fontSizeSubtitle,
                    ),
                  ),
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
                    onPressed: () => saveValueAndPop(_actualFabDirection!),
                  ),
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
