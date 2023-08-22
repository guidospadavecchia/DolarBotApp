import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../classes/app_config.dart';
import '../common/rich_text_span/rich_text_span.dart';
import 'base/step_base.dart';

class StepWelcome extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final int totalStepCount;
  final String title;
  final bool showStep;

  StepWelcome(
    this.context, {
    this.stepIndex = 0,
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
      SizedBox(
        child: Image.asset(
          AppConfig.logo.border,
          scale: 3.0,
          height: 128,
          width: 128,
          filterQuality: FilterQuality.high,
        ),
        width: SizeConfig.blockSizeVertical * 18,
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(height: SizeConfig.blockSizeVertical * 0.2),
          children: [
            RichTextSpan.text(context, "¡Hola 👋!", fontSize: SizeConfig.blockSizeVertical * 4, bold: true),
            RichTextSpan.newLine(context, lines: 3),
            RichTextSpan.text(
              context,
              "En esta breve guía vas a conocer todas las funcionalidades de ",
              fontSize: SizeConfig.blockSizeVertical * 2.5,
            ),
            RichTextSpan.text(
              context,
              AppConfig.appDisplayName,
              bold: true,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
            ),
          ],
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(
              context,
              "Deslizá para pasar de página",
              fontSize: SizeConfig.blockSizeVertical * 2,
              italic: true,
            ),
            RichTextSpan.newLine(context, lines: 2),
            ...RichTextSpan.icon(
              context,
              FontAwesomeIcons.chevronLeft,
              ThemeManager.getPrimaryAccentColor(context),
              size: SizeConfig.blockSizeVertical * 5,
              hideBrackets: true,
            )
          ],
        ),
      ),
      const SizedBox.shrink(),
    ];
  }
}
