import '../../../classes/size_config.dart';
import '../../../classes/theme_manager.dart';
import 'package:flutter/material.dart';

class RichTextSpan {
  static TextSpan newLine(BuildContext context, {int lines = 1}) {
    return text(context, "\n" * lines);
  }

  static TextSpan text(BuildContext context, String text, {bool bold = false, bool italic = false, double? fontSize}) {
    return TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize ?? SizeConfig.blockSizeVertical * 2,
        fontFamily: "Roboto",
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: ThemeManager.getPrimaryTextColor(context),
      ),
    );
  }

  static List<InlineSpan> icon(
    BuildContext context,
    IconData icon,
    Color color, {
    PlaceholderAlignment alignment = PlaceholderAlignment.middle,
    double? size,
    String? text,
    bool hideBrackets = false,
  }) {
    return [
      hideBrackets ? RichTextSpan.text(context, " ", bold: false) : RichTextSpan.text(context, " [ ", bold: false),
      WidgetSpan(
        alignment: alignment,
        child: Icon(
          icon,
          color: color,
          size: size ?? SizeConfig.blockSizeVertical * 2,
        ),
      ),
      if (text != null) RichTextSpan.text(context, " ${text}", bold: true),
      hideBrackets ? RichTextSpan.text(context, " ", bold: false) : RichTextSpan.text(context, " ] ", bold: false),
    ];
  }
}
