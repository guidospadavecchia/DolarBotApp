import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputAmount extends StatelessWidget {
  final TextEditingController textController;
  final String? title;
  final int maxDigits;

  const InputAmount({
    Key? key,
    required this.textController,
    this.title,
    this.maxDigits = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      child: TextField(
        autofocus: true,
        controller: textController,
        decoration: InputDecoration(
          labelText: title ?? "Ingresá un monto:",
          labelStyle: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 2.5,
            height: 0.5,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
          contentPadding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical),
          isDense: true,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxDigits)
        ],
        textAlign: TextAlign.left,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 22,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: ThemeManager.getPrimaryTextColor(context),
        ),
      ),
    );
  }
}
