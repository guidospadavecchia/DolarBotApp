import 'package:dolarbot_app/widgets/common/rich_text_span/rich_text_span.dart';
import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepThree extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final int totalStepCount;
  final String title;
  final bool showStep;

  StepThree(
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
            RichTextSpan.text(context,
                "Podés compartir cualquier cotización de forma muy sencilla, y a través del medio que más te guste."),
            RichTextSpan.newLine(context, lines: 2),
            RichTextSpan.text(context, "Pueden ser tanto las que están en tu"),
            ...RichTextSpan.icon(
                context, FontAwesomeIcons.home, ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom, text: " Inicio"),
            RichTextSpan.text(context, "como las que no.")
          ],
        ),
      ),
      SizedBox(
        width: SizeConfig.screenWidth / 1.5,
        child: Image.asset(
          "assets/images/general/menu_share.png",
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(context, "Presioná"),
            ...RichTextSpan.icon(context, Icons.share, ThemeManager.getPrimaryAccentColor(context)),
            RichTextSpan.text(context, "desde el menú"),
            ...RichTextSpan.icon(
                context, Icons.more_horiz, ThemeManager.getPrimaryTextColor(context)),
            RichTextSpan.text(context, "de la cotización. O bien, desde la tarjeta."),
          ],
        ),
      ),
    ];
  }
}
