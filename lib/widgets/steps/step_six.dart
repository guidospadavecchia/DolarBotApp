import 'package:dolarbot_app/widgets/common/rich_text_span/rich_text_span.dart';
import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepSix extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final int totalStepCount;
  final String title;
  final bool showStep;

  StepSix(
    this.context, {
    required this.stepIndex,
    required this.totalStepCount,
    required this.title,
    required this.showStep,
  }) : super(
          stepIndex: stepIndex,
          totalStepCount: totalStepCount,
          title: title,
          showStep: showStep,
        );

  @override
  List<Widget> body() {
    return [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(context, "Pensamos en todo.", bold: true, italic: true),
            RichTextSpan.newLine(context, lines: 2),
            RichTextSpan.text(
                context, "Por eso, si querés realizar conversiones, podés hacerlo con la "),
            RichTextSpan.text(context, "calculadora", bold: true),
            RichTextSpan.text(context, " integrada en cada cotización."),
          ],
        ),
      ),
      SizedBox(
        width: SizeConfig.screenWidth / 1.8,
        child: Image.asset(
          "assets/images/general/menu_calc.png",
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(context, "Presioná"),
            ...RichTextSpan.icon(
                context, FontAwesomeIcons.calculator, ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom),
            RichTextSpan.text(context, "en el menú"),
            ...RichTextSpan.icon(
                context, Icons.more_horiz, ThemeManager.getPrimaryTextColor(context)),
            RichTextSpan.text(context,
                "dentro de la cotización para abrir la calculadora y realizar tus conversiones."),
          ],
        ),
      ),
    ];
  }
}
