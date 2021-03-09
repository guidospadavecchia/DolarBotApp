import 'package:dolarbot_app/screens/home/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepFour extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepFour(
    this.context, {
    this.stepIndex,
    @required this.title,
    @required this.showStep,
  }) : super(stepIndex: stepIndex, title: title, showStep: showStep);

  @override
  List<Widget> body() {
    return [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(context, "Pensamos en todo.", bold: true, italic: true),
            writeNewLine(context),
            writeText(context, "Por eso, si querés realizar conversiones, "),
            writeText(context, "podés hacerlo con la "),
            writeText(context, "calculadora", bold: true),
            writeNewLine(context),
            writeText(context, " integrada en cada cotización.")
          ],
        ),
      ),
      SizedBox(
        height: 256,
        child: Image.asset(
          "assets/images/general/menu_calc.png",
          height: 256,
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(context, "Presioná [ "),
            writeIcon(FontAwesomeIcons.calculator,
                ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom),
            writeText(context, " ] en el menú [ "),
            writeIcon(
                Icons.more_horiz, ThemeManager.getPrimaryTextColor(context)),
            writeText(context,
                " ] dentro de la cotización para abrir la calculadora y realizar tus conversiones 💱. Simple, ¿No?"),
          ],
        ),
      ),
    ];
  }
}
