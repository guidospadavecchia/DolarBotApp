import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

import '../../../../classes/dolarbot_icons.dart';
import '../../../../classes/settings.dart';
import '../../../../classes/size_config.dart';
import '../../../../classes/theme_manager.dart';
import '../../../../util/constants.dart';
import '../../../../widgets/common/blur_dialog.dart';
import '../../../../widgets/common/pills/pill.dart';
import '../../../../widgets/common/simple_button.dart';
import '../../../../widgets/common/toasts/toast_ok.dart';

class CardTagColorsDialog extends StatefulWidget {
  @override
  _CardTagColorsDialogState createState() => _CardTagColorsDialogState();
}

class _CardTagColorsDialogState extends State<CardTagColorsDialog> {
  final EdgeInsets tileContentPadding = EdgeInsets.symmetric(
    vertical: SizeConfig.blockSizeVertical * 1.5,
    horizontal: SizeConfig.blockSizeHorizontal * 4,
  );

  late bool _isTagColored;
  bool? _actualIsTagColored;

  @override
  Widget build(BuildContext context) {
    _isTagColored = Provider.of<Settings>(context, listen: false).getTagIsColored();

    if (_actualIsTagColored == null) {
      _actualIsTagColored = _isTagColored;
    }

    return BlurDialog(
      dialog: Dialog(
        insetPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
        child: Container(
          width: SizeConfig.screenWidth * 0.8,
          height: SizeConfig.screenHeight * 0.60,
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
                  "Elegí si las etiquetas en las tarjetas del inicio se diferencian por color:",
                ),
              ),
              Expanded(
                child: SizedBox.shrink(),
              ),
              Container(
                child: RadioListTile<bool>(
                  contentPadding: tileContentPadding,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Etiquetas con colores',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          PillExample(
                            iconAsset: DolarBotIcons.banks.bbva,
                            gradient: DolarBotConstants.kGradiantBBVA,
                            color: Color.fromRGBO(30, 90, 50, 1),
                            foreColor: Colors.white,
                            tag: 'DÓLAR',
                          ),
                          SizedBox(width: SizeConfig.blockSizeHorizontal),
                          PillExample(
                            iconAsset: DolarBotIcons.banks.supervielle,
                            gradient: DolarBotConstants.kGradiantSupervielle,
                            color: Color.fromRGBO(0, 64, 180, 1),
                            foreColor: Colors.white,
                            tag: 'EURO',
                          ),
                          SizedBox(width: SizeConfig.blockSizeHorizontal),
                          PillExample(
                            iconAsset: DolarBotIcons.banks.ciudad,
                            gradient: DolarBotConstants.kGradiantCiudad,
                            color: Colors.orange.shade400,
                            foreColor: Colors.black87,
                            tag: 'REAL',
                          ),
                        ],
                      ),
                    ],
                  ),
                  value: true,
                  groupValue: _actualIsTagColored,
                  activeColor: ThemeManager.getPrimaryAccentColor(context),
                  onChanged: (value) {
                    setState(() {
                      _actualIsTagColored = value;
                    });
                  },
                ),
              ),
              Container(
                child: RadioListTile<bool>(
                  contentPadding: tileContentPadding,
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Etiquetas neutras',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            PillExample(
                              iconAsset: DolarBotIcons.banks.bbva,
                              gradient: DolarBotConstants.kGradiantBBVA,
                              tag: 'DÓLAR',
                            ),
                            SizedBox(width: SizeConfig.blockSizeHorizontal),
                            PillExample(
                              iconAsset: DolarBotIcons.banks.supervielle,
                              gradient: DolarBotConstants.kGradiantSupervielle,
                              tag: 'EURO',
                            ),
                            SizedBox(width: SizeConfig.blockSizeHorizontal),
                            PillExample(
                              iconAsset: DolarBotIcons.banks.ciudad,
                              gradient: DolarBotConstants.kGradiantCiudad,
                              tag: 'REAL',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  value: false,
                  groupValue: _actualIsTagColored,
                  activeColor: ThemeManager.getPrimaryAccentColor(context),
                  onChanged: (value) {
                    setState(() {
                      _actualIsTagColored = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2,
                  left: SizeConfig.blockSizeHorizontal * 8,
                  right: SizeConfig.blockSizeHorizontal * 8,
                ),
                child: Text(
                  "Sólo aplica para las cotizaciones de\nDólar, Euro y Real.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
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
                    onPressed: () => saveValueAndPop(_actualIsTagColored!),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void saveValueAndPop(bool value) async {
    Provider.of<Settings>(context, listen: false).saveIsTagColored(value);
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

class PillExample extends StatelessWidget {
  final String tag;
  final Color color;
  final Color foreColor;
  final String iconAsset;
  final List<Color> gradient;

  const PillExample({
    Key? key,
    required this.tag,
    this.color = Colors.black54,
    this.foreColor = Colors.white,
    required this.iconAsset,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 70,
      decoration: BoxDecoration(
        boxShadow: [
          const BoxShadow(
            blurRadius: 5,
            spreadRadius: 1,
            color: Colors.black26,
            offset: Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            Container(
              child: Image.asset(
                iconAsset,
                width: SizeConfig.blockSizeVertical * 4,
                height: SizeConfig.blockSizeVertical * 4,
                filterQuality: FilterQuality.high,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Pill(
              color: color,
              text: tag,
              foreColor: foreColor,
            ),
          ],
        ),
      ),
    );
  }
}
