import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:dolarbot_app/classes/theme_manager.dart';

abstract class StepBase extends StatelessWidget {
  final int stepIndex;
  final String title;
  final bool showStep;

  const StepBase({
    Key key,
    this.stepIndex = 0,
    this.title,
    this.showStep = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildStepHeader(context, stepIndex, title, showStep),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...body(),
              ],
            ),
          ),
        ),
        buildStepFooter(context, stepIndex),
      ],
    );
  }

  List<Widget> body();
}

Widget buildStepHeader(
    BuildContext context, int step, String title, bool showStep) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(
            left: showStep ? 45 : 0, top: 26, bottom: 15, right: 20),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 35,
          margin: EdgeInsets.only(left: 25),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
            color: ThemeManager.getPrimaryAccentColor(context),
          ),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                color: ThemeManager.getGlobalBackgroundColor(context),
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      if (showStep)
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ThemeManager.getPrimaryAccentColor(context),
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 22,
                    color: ThemeManager.getGlobalBackgroundColor(context),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
    ],
  );
}

Widget buildStepFooter(BuildContext context, int stepIndex) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ThemeManager.getPrimaryAccentColor(context).withAlpha(100),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
          width: 250,
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: ThemeManager.getPrimaryAccentColor(context),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
          width: 42 * (stepIndex.toDouble() + 1),
          height: 10,
        ),
      ],
    ),
  );
}

TextSpan writeNewLine(BuildContext context, {int lines = 1}) {
  return writeText(context, "\n" * lines);
}

TextSpan writeText(BuildContext context, String text,
    {bool bold = false, bool italic = false, double fontSize: 16}) {
  return TextSpan(
    text: text,
    style: TextStyle(
      fontSize: fontSize,
      fontFamily: "Roboto",
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      color: ThemeManager.getPrimaryTextColor(context),
    ),
  );
}

List<InlineSpan> writeIcon(
  BuildContext context,
  IconData icon,
  Color color, {
  PlaceholderAlignment alignment = PlaceholderAlignment.middle,
  double size = 20,
  String text,
  bool hideBrackets = false,
}) {
  return [
    hideBrackets
        ? writeText(context, " ", bold: false)
        : writeText(context, " [ ", bold: false),
    WidgetSpan(
      alignment: alignment,
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    ),
    if (text != null) writeText(context, " ${text}", bold: true),
    hideBrackets
        ? writeText(context, " ", bold: false)
        : writeText(context, " ] ", bold: false),
  ];
}