import 'dart:ui' as ui;
import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/classes/settings.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/simple_button.dart';
import 'package:dolarbot_app/widgets/common/toasts/toast_ok.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class CardGestureDismissDialog extends StatefulWidget {
  @override
  _CardGestureDismissDialogState createState() => _CardGestureDismissDialogState();
}

class _CardGestureDismissDialogState extends State<CardGestureDismissDialog> {
  late DismissDirection _dismissDirection;
  DismissDirection? _actualDismissDirection;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets tileContentPadding = EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 1.5,
        horizontal: SizeConfig.blockSizeHorizontal * 4);
    final double fontSize = SizeConfig.blockSizeVertical * 2.2;
    _dismissDirection = Provider.of<Settings>(context, listen: false).getCardGestureDismiss();

    if (_actualDismissDirection == null) {
      _actualDismissDirection = _dismissDirection;
    }

    return BlurDialog(
      dialog: Dialog(
        insetPadding: EdgeInsets.all(SizeConfig.blockSizeVertical * 4),
        child: Container(
          width: SizeConfig.screenWidth * 0.8,
          height: SizeConfig.screenHeight * 0.65,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overScroll) {
              overScroll.disallowGlow();
              return false;
            },
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
                      "Seleccioná la forma que te quede más cómoda para eliminar las tarjetas del Inicio:"),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 2,
                ),
                Container(
                  child: RadioListTile<DismissDirection>(
                    contentPadding: tileContentPadding,
                    title: Text(
                      'Hacia la Izquierda',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: _buildExample(DismissDirection.endToStart),
                    value: DismissDirection.endToStart,
                    groupValue: _actualDismissDirection,
                    activeColor: ThemeManager.getPrimaryAccentColor(context),
                    onChanged: (value) {
                      setState(() {
                        _actualDismissDirection = value;
                      });
                    },
                  ),
                ),
                Container(
                  child: RadioListTile<DismissDirection>(
                    contentPadding: tileContentPadding,
                    title: Text(
                      'Hacia la derecha',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: _buildExample(DismissDirection.startToEnd),
                    value: DismissDirection.startToEnd,
                    groupValue: _actualDismissDirection,
                    activeColor: ThemeManager.getPrimaryAccentColor(context),
                    onChanged: (value) {
                      setState(() {
                        _actualDismissDirection = value;
                      });
                    },
                  ),
                ),
                Container(
                  child: RadioListTile<DismissDirection>(
                    contentPadding: tileContentPadding,
                    title: Text(
                      'Ambas direcciones',
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: _buildExample(DismissDirection.horizontal),
                    value: DismissDirection.horizontal,
                    groupValue: _actualDismissDirection,
                    activeColor: ThemeManager.getPrimaryAccentColor(context),
                    onChanged: (value) {
                      setState(() {
                        _actualDismissDirection = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox.shrink(),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
                    child: SimpleButton(
                      text: 'Aplicar',
                      icon: Icons.check_outlined,
                      onPressed: () => saveValueAndPop(_actualDismissDirection!),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildExample(DismissDirection direction) {
    double redAreaHeight = SizeConfig.blockSizeVertical * 5;
    double redAreaWidth = SizeConfig.blockSizeHorizontal * 8;
    double greenAreaHeight = SizeConfig.blockSizeVertical * 6.5;
    double greenAreaWidth = SizeConfig.blockSizeHorizontal * 16;
    double deleteIconSize = SizeConfig.blockSizeVertical * 2.5;
    double handGestureIconSize = SizeConfig.blockSizeVertical * 4;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: SizeConfig.blockSizeVertical / 2,
        ),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          textDirection: direction == DismissDirection.endToStart
              ? ui.TextDirection.ltr
              : ui.TextDirection.rtl,
          children: [
            if (direction == DismissDirection.horizontal)
              Container(
                height: redAreaHeight,
                width: redAreaWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: direction == DismissDirection.endToStart
                        ? const Radius.circular(0)
                        : direction == DismissDirection.horizontal
                            ? const Radius.circular(0)
                            : Radius.circular(SizeConfig.blockSizeVertical),
                    bottomLeft: direction == DismissDirection.endToStart
                        ? const Radius.circular(0)
                        : direction == DismissDirection.horizontal
                            ? const Radius.circular(0)
                            : Radius.circular(SizeConfig.blockSizeVertical),
                    topRight: direction == DismissDirection.startToEnd
                        ? const Radius.circular(0)
                        : Radius.circular(SizeConfig.blockSizeVertical),
                    bottomRight: direction == DismissDirection.startToEnd
                        ? const Radius.circular(0)
                        : Radius.circular(SizeConfig.blockSizeVertical),
                  ),
                  color: Colors.red[800],
                ),
                child: Icon(
                  Icons.delete,
                  size: deleteIconSize,
                  color: Colors.white,
                ),
              ),
            Container(
              height: greenAreaHeight,
              width: direction == DismissDirection.horizontal ? greenAreaWidth * 2 : greenAreaWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: direction == DismissDirection.endToStart
                      ? const Radius.circular(0)
                      : Radius.circular(SizeConfig.blockSizeVertical),
                  bottomLeft: direction == DismissDirection.endToStart
                      ? const Radius.circular(0)
                      : Radius.circular(SizeConfig.blockSizeVertical),
                  topRight: direction == DismissDirection.startToEnd
                      ? const Radius.circular(0)
                      : Radius.circular(SizeConfig.blockSizeVertical),
                  bottomRight: direction == DismissDirection.startToEnd
                      ? const Radius.circular(0)
                      : Radius.circular(SizeConfig.blockSizeVertical),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: DolarBotConstants.kGradiantDefault),
              ),
              child: direction == DismissDirection.endToStart
                  ? Icon(
                      FontAwesomeIcons.solidHandPointLeft,
                      size: handGestureIconSize,
                      color: Colors.white,
                    )
                  : direction == DismissDirection.startToEnd
                      ? Icon(
                          FontAwesomeIcons.solidHandPointRight,
                          size: handGestureIconSize,
                          color: Colors.white,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidHandPointLeft,
                              size: handGestureIconSize,
                              color: Colors.white,
                            ),
                            Icon(
                              FontAwesomeIcons.solidHandPointRight,
                              size: handGestureIconSize,
                              color: Colors.white,
                            ),
                          ],
                        ),
            ),
            Container(
              height: redAreaHeight,
              width: redAreaWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: direction == DismissDirection.endToStart
                      ? const Radius.circular(0)
                      : Radius.circular(SizeConfig.blockSizeVertical),
                  bottomLeft: direction == DismissDirection.endToStart
                      ? const Radius.circular(0)
                      : Radius.circular(SizeConfig.blockSizeVertical),
                  topRight: direction == DismissDirection.startToEnd
                      ? const Radius.circular(0)
                      : direction == DismissDirection.horizontal
                          ? const Radius.circular(0)
                          : Radius.circular(SizeConfig.blockSizeVertical),
                  bottomRight: direction == DismissDirection.endToStart
                      ? Radius.circular(SizeConfig.blockSizeVertical)
                      : const Radius.circular(0),
                ),
                color: Colors.red[800],
              ),
              child: Icon(
                Icons.delete,
                size: deleteIconSize,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void saveValueAndPop(DismissDirection value) async {
    Provider.of<Settings>(context, listen: false).saveCardGestureDismiss(value);
    await Future.delayed(Duration(milliseconds: 50))
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
