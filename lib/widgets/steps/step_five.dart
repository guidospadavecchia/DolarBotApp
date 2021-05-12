import 'package:dolarbot_app/widgets/common/rich_text_span/rich_text_span.dart';
import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepFive extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final int totalStepCount;
  final String title;
  final bool showStep;

  StepFive(
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
            RichTextSpan.text(context, "¿Querés quitar una tarjeta de favoritos?"),
            RichTextSpan.newLine(context, lines: 2),
            RichTextSpan.text(context, "Deslizala hacia el costado.\n", bold: true, italic: true),
            RichTextSpan.newLine(context),
            RichTextSpan.text(context, "Así de simple."),
          ],
        ),
      ),
      SizedBox(
        width: SizeConfig.screenHeight / 2,
        child: Image.asset(
          "assets/images/general/delete.png",
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(context, "En la sección de"),
            ...RichTextSpan.icon(
              context,
              FontAwesomeIcons.cog,
              ThemeManager.getDrawerMenuItemIconColor(context),
              alignment: PlaceholderAlignment.bottom,
              text: "Opciones",
            ),
            RichTextSpan.text(context, ">", bold: true),
            ...RichTextSpan.icon(
              context,
              FontAwesomeIcons.exchangeAlt,
              ThemeManager.getDrawerMenuItemIconColor(context),
              alignment: PlaceholderAlignment.bottom,
              text: "Gesto de eliminación de tarjeta",
            ),
            RichTextSpan.text(context,
                " tenés la posibilidad de elegir el gesto que prefieras y que más cómodo te quede."),
          ],
        ),
      ),
    ];
  }
}
