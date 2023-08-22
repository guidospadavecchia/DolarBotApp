import '../common/rich_text_span/rich_text_span.dart';
import 'base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepFour extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final int totalStepCount;
  final String title;
  final bool showStep;

  StepFour(
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
            RichTextSpan.text(context, "Las tarjetas se agregan al"),
            ...RichTextSpan.icon(context, FontAwesomeIcons.home, ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom, text: " Inicio"),
            RichTextSpan.text(context, "según las vayas añadiendo, pero también podés ordenarlas a tu gusto."),
          ],
        ),
      ),
      SizedBox(
        width: SizeConfig.screenHeight / 2,
        child: Image.asset(
          "assets/images/general/reorder.png",
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(context, "Mantené presionada una tarjeta"),
            ...RichTextSpan.icon(context, Icons.touch_app_rounded, ThemeManager.getPrimaryAccentColor(context),
                alignment: PlaceholderAlignment.bottom, size: 18),
            RichTextSpan.text(context, "hasta que se achique y se torne semi transparente. Luego, arrastrala a la posición que quieras y soltala"),
            ...RichTextSpan.icon(context, FontAwesomeIcons.solidHandPaper, ThemeManager.getPrimaryAccentColor(context)),
            RichTextSpan.text(context, "."),
          ],
        ),
      ),
    ];
  }
}
