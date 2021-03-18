import 'dart:ui' as ui;

import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/util/constants.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
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
  DismissDirection _dismissDirection;
  DismissDirection _actualDismissDirection;

  @override
  Widget build(BuildContext context) {
    _dismissDirection = Provider.of<Settings>(context, listen: false).getCardGestureDismiss();

    if (_actualDismissDirection == null) {
      _actualDismissDirection = _dismissDirection;
    }

    return BlurDialog(
      dialog: Dialog(
        insetPadding: EdgeInsets.all(25),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 480,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 25, right: 15),
                child: Text(
                    "Seleccioná la forma que te quede más cómoda para eliminar las tarjetas del Inicio."),
              ),
              SizedBox(
                height: 10,
              ),
              RadioListTile<DismissDirection>(
                contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                title: Text(
                  'Hacia la Izquierda',
                  style: TextStyle(
                    fontSize: 16,
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
              SizedBox(
                height: 10,
              ),
              RadioListTile<DismissDirection>(
                contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                title: Text(
                  'Hacia la derecha',
                  style: TextStyle(
                    fontSize: 16,
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
              SizedBox(
                height: 10,
              ),
              RadioListTile<DismissDirection>(
                contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                title: Text(
                  'Ambas direcciones',
                  style: TextStyle(
                    fontSize: 16,
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
              SizedBox(
                height: 20,
              ),
              Center(
                child: DialogButton(
                  text: 'Aplicar',
                  icon: Icons.check_outlined,
                  onPressed: () => saveValueAndPop(_actualDismissDirection),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildExample(DismissDirection direction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          textDirection: direction == DismissDirection.endToStart
              ? ui.TextDirection.ltr
              : ui.TextDirection.rtl,
          children: [
            if (direction == DismissDirection.horizontal)
              Container(
                height: 38,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: direction == DismissDirection.endToStart
                        ? Radius.circular(0)
                        : direction == DismissDirection.horizontal
                            ? Radius.circular(0)
                            : Radius.circular(5),
                    bottomLeft: direction == DismissDirection.endToStart
                        ? Radius.circular(0)
                        : direction == DismissDirection.horizontal
                            ? Radius.circular(0)
                            : Radius.circular(5),
                    topRight: direction == DismissDirection.startToEnd
                        ? Radius.circular(0)
                        : Radius.circular(5),
                    bottomRight: direction == DismissDirection.startToEnd
                        ? Radius.circular(0)
                        : Radius.circular(5),
                  ),
                  color: Colors.red[800],
                ),
                child: Icon(
                  Icons.delete,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            Container(
              height: 50,
              width: direction == DismissDirection.horizontal ? 120 : 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: direction == DismissDirection.endToStart
                      ? Radius.circular(0)
                      : Radius.circular(5),
                  bottomLeft: direction == DismissDirection.endToStart
                      ? Radius.circular(0)
                      : Radius.circular(5),
                  topRight: direction == DismissDirection.startToEnd
                      ? Radius.circular(0)
                      : Radius.circular(5),
                  bottomRight: direction == DismissDirection.startToEnd
                      ? Radius.circular(0)
                      : Radius.circular(5),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: DolarBotConstants.kGradiantDefault),
              ),
              child: direction == DismissDirection.endToStart
                  ? Icon(
                      FontAwesomeIcons.solidHandPointLeft,
                      size: 32,
                      color: Colors.white,
                    )
                  : direction == DismissDirection.startToEnd
                      ? Icon(
                          FontAwesomeIcons.solidHandPointRight,
                          size: 32,
                          color: Colors.white,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidHandPointLeft,
                              size: 32,
                              color: Colors.white,
                            ),
                            Icon(
                              FontAwesomeIcons.solidHandPointRight,
                              size: 32,
                              color: Colors.white,
                            ),
                          ],
                        ),
            ),
            Container(
              height: 38,
              width: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: direction == DismissDirection.endToStart
                      ? Radius.circular(0)
                      : Radius.circular(5),
                  bottomLeft: direction == DismissDirection.endToStart
                      ? Radius.circular(0)
                      : Radius.circular(5),
                  topRight: direction == DismissDirection.startToEnd
                      ? Radius.circular(0)
                      : direction == DismissDirection.horizontal
                          ? Radius.circular(0)
                          : Radius.circular(5),
                  bottomRight: direction == DismissDirection.endToStart
                      ? Radius.circular(5)
                      : Radius.circular(0),
                ),
                color: Colors.red[800],
              ),
              child: Icon(
                Icons.delete,
                size: 18,
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
              Duration(milliseconds: 100),
              () => showToastWidget(
                ToastOk(),
              ),
            ),
          },
        );
  }
}
