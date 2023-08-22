import 'package:auto_size_text_field/auto_size_text_field.dart';
import '../../../classes/size_config.dart';
import '../../../classes/theme_manager.dart';
import 'package:flutter/material.dart';

class InputConverted extends StatelessWidget {
  final String? title;
  final TextEditingController? textController;

  const InputConverted({
    Key? key,
    this.title,
    this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title!,
          style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 2,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.normal,
            color: ThemeManager.getPrimaryTextColor(context),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical,
        ),
        Container(
          width: SizeConfig.screenWidth * 0.7,
          child: AutoSizeTextField(
            enabled: true,
            readOnly: true,
            controller: textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical / 2),
              isDense: true,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 3,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: ThemeManager.getPrimaryTextColor(context),
            ),
          ),
        ),
      ],
    );
  }
}
