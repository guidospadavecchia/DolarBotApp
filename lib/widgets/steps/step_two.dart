import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepTwo extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepTwo(
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
            writeText(context, "El"),
            ...writeIcon(context, FontAwesomeIcons.home,
                ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom, text: " Inicio"),
            writeText(context, "es tu pantalla principal."),
            writeNewLine(context, lines: 2),
            writeText(context,
                "Acá van a aparecer tus cotizaciones favoritas en forma de "),
            writeText(context, "tarjetas", bold: true),
            writeText(context, ". "),
            writeText(context, "Super cool ", italic: true),
            writeText(context, "😎."),
            writeNewLine(context, lines: 2),
            writeText(context, "¡Y no hay límite!"),
            writeNewLine(context),
            writeText(context, "Podés agregar todas las que quieras.",
                bold: true)
          ],
        ),
      ),
      SizedBox(
        width: 256,
        child: Image.asset(
          "assets/images/general/home_bg.png",
          width: 256,
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(context, "También podés quitarlas, claro."),
            writeNewLine(context),
            writeText(context, "Tocá en la"),
            ...writeIcon(context, FontAwesomeIcons.times, Colors.red),
            writeText(context,
                "que está ubicada en la tarjeta y la misma desaparecerá de inmediato."),
          ],
        ),
      ),
    ];
  }
}
