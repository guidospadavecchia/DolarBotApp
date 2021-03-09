import 'package:dolarbot_app/screens/home/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepWelcome extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepWelcome(
    this.context, {
    this.stepIndex = 0,
    @required this.title,
    @required this.showStep,
  }) : super(stepIndex: stepIndex, title: title, showStep: showStep);

  @override
  List<Widget> body() {
    return [
      SizedBox.shrink(),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(height: 1.3),
          children: [
            writeText(context, "¡Hola 👋!", fontSize: 40, bold: true),
            writeNewLine(context, lines: 4),
            writeText(
              context,
              "En esta breve guía vas a conocer todas las funcionalidades de ",
              fontSize: 20,
            ),
            writeText(
              context,
              "DolarBot",
              bold: true,
              fontSize: 24,
            ),
          ],
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(
              context,
              "Deslizá para pasar de página",
              fontSize: 20,
              italic: true,
            ),
            writeNewLine(context, lines: 2),
            ...writeIcon(
              context,
              FontAwesomeIcons.chevronLeft,
              ThemeManager.getPrimaryAccentColor(context),
              size: 40,
              hideBrackets: true,
            )
          ],
        ),
      ),
      SizedBox.shrink(),
    ];
  }
}
