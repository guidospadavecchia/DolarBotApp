import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/widgets/common/simple_button.dart';
import 'package:flutter/material.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';

class TextDialog extends StatelessWidget {
  final String title;
  final String text;
  final TextAlign textAlign;
  final String buttonText;
  final IconData buttonIcon;
  final double titleFontSize;
  final double? width;
  final EdgeInsets? insetPadding;

  const TextDialog({
    Key? key,
    required this.title,
    required this.text,
    this.textAlign = TextAlign.justify,
    this.buttonText = "Cerrar",
    this.buttonIcon = Icons.close,
    this.titleFontSize = 20,
    this.width = null,
    this.insetPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurDialog(
      dialog: Dialog(
        insetPadding: insetPadding ?? EdgeInsets.all(SizeConfig.blockSizeVertical * 4),
        child: Container(
          constraints: BoxConstraints(maxHeight: SizeConfig.screenHeight * 0.7),
          width: width ?? SizeConfig.screenWidth * 0.8,
          padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        color: ThemeManager.getPrimaryTextColor(context),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    indent: SizeConfig.blockSizeVertical * 2,
                    endIndent: SizeConfig.blockSizeVertical * 2,
                    height: 0,
                  ),
                ],
              ),
              LimitedBox(
                maxHeight: SizeConfig.screenHeight * 0.5,
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowGlow();
                    return false;
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeVertical * 2),
                    child: Scrollbar(
                      isAlwaysShown: false,
                      radius: Radius.circular(SizeConfig.blockSizeVertical),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
                          child: Text(
                            text,
                            textAlign: textAlign,
                            style: TextStyle(
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: SimpleButton(
                  text: buttonText,
                  icon: buttonIcon,
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
