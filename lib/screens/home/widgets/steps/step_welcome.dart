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
            writeText(context, "¡Hola 👋!", fontSize: 40),
            writeText(context, "\n\n\n\n"),
            writeText(
              context,
              "En esta breve guía vamos a darte a conocer 4 aspectos fundamentales de ",
              fontSize: 20,
            ),
            writeText(
              context,
              "DolarBot",
              isBold: true,
              fontSize: 20,
            ),
            writeText(context, "."),
          ],
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(
              context,
              "Deslizá para pasar de página.\n\n",
              fontSize: 20,
            ),
            writeIcon(
              FontAwesomeIcons.arrowCircleLeft,
              ThemeManager.getPrimaryAccentColor(context),
              size: 40,
            )
          ],
        ),
      ),
      SizedBox.shrink(),
    ];
  }
}
