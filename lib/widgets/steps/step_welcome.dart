import 'package:dolarbot_app/classes/app_config.dart';
import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepWelcome extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepWelcome(
    this.context, {
    this.stepIndex = 0,
    required this.title,
    required this.showStep,
  }) : super(stepIndex: stepIndex, title: title, showStep: showStep);

  @override
  List<Widget> body() {
    return [
      const SizedBox.shrink(),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(height: 1.3),
          children: [
            writeText(context, "¡Hola 👋!", fontSize: SizeConfig.blockSizeVertical * 5, bold: true),
            writeNewLine(context, lines: 4),
            writeText(
              context,
              "En esta breve guía vas a conocer todas las funcionalidades de ",
              fontSize: SizeConfig.blockSizeVertical * 2.5,
            ),
            writeText(
              context,
              AppConfig.of(context).appDisplayName,
              bold: true,
              fontSize: SizeConfig.blockSizeVertical * 3,
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
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              italic: true,
            ),
            writeNewLine(context, lines: 2),
            ...writeIcon(
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
