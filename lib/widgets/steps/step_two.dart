import 'package:dolarbot_app/widgets/common/rich_text_span/rich_text_span.dart';
import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepTwo extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepTwo(
    this.context, {
    required this.stepIndex,
    required this.title,
    required this.showStep,
  }) : super(stepIndex: stepIndex, title: title, showStep: showStep);

  @override
  List<Widget> body() {
    return [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(context, "El"),
            ...RichTextSpan.icon(
                context, FontAwesomeIcons.home, ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom, text: " Inicio"),
            RichTextSpan.text(context, "es tu pantalla principal."),
            RichTextSpan.newLine(context, lines: 2),
            RichTextSpan.text(
                context, "Acá van a aparecer tus cotizaciones favoritas en forma de "),
            RichTextSpan.text(context, "tarjetas", bold: true),
            RichTextSpan.text(context, ". "),
            RichTextSpan.text(context, "Super cool ", italic: true),
            RichTextSpan.text(context, "😎."),
            RichTextSpan.newLine(context, lines: 2),
            RichTextSpan.text(context, "¡Y no hay límite!"),
            RichTextSpan.newLine(context),
            RichTextSpan.text(context, "Podés agregar todas las que quieras.", bold: true)
          ],
        ),
      ),
      SizedBox(
        width: SizeConfig.screenWidth / 1.8,
        child: Image.asset(
          "assets/images/general/home_bg.png",
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(context, "También podés quitarlas, claro."),
            RichTextSpan.newLine(context),
            RichTextSpan.text(context, "Tocá en la"),
            ...RichTextSpan.icon(context, FontAwesomeIcons.times, Colors.red),
            RichTextSpan.text(
                context, "que está ubicada en la tarjeta y la misma desaparecerá de inmediato."),
          ],
        ),
      ),
    ];
  }
}
