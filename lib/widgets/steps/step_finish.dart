import 'package:dolarbot_app/classes/app_config.dart';
import 'package:dolarbot_app/widgets/common/rich_text_span/rich_text_span.dart';
import 'package:dolarbot_app/widgets/common/simple_button.dart';
import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

class StepFinish extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final int totalStepCount;
  final String title;
  final bool showStep;
  final bool isComingFromOptions;

  StepFinish(
    this.context, {
    this.stepIndex = 0,
    required this.totalStepCount,
    required this.title,
    required this.showStep,
    this.isComingFromOptions = false,
  }) : super(
          stepIndex: stepIndex,
          totalStepCount: totalStepCount,
          title: title,
          showStep: showStep,
        );

  @override
  List<Widget> body() {
    return [
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  RichTextSpan.text(context, "¡Listo 👌!",
                      fontSize: SizeConfig.blockSizeVertical * 4),
                  RichTextSpan.newLine(context, lines: 4),
                  if (!isComingFromOptions) ..._buildFinishText() else ..._buildOptionsFinishText(),
                ],
              ),
            ),
          ],
        ),
      ),
      SimpleButton(
        icon: Icons.check,
        text: "Entendido",
        onPressed: () => _finishTutorial(),
      ),
    ];
  }

  void _finishTutorial() {
    var settings = Hive.box('settings');
    settings.put('isFirstTime', false).then((_) => Navigator.of(context).pop());
  }

  List<InlineSpan> _buildFinishText() {
    return [
      RichTextSpan.text(
        context,
        "Ya podés comenzar a utilizar ",
        fontSize: SizeConfig.blockSizeVertical * 2.5,
      ),
      RichTextSpan.text(
        context,
        AppConfig.appDisplayName,
        bold: true,
        fontSize: SizeConfig.blockSizeVertical * 3,
      ),
      RichTextSpan.newLine(context, lines: 3),
      RichTextSpan.text(context, "Recordá que esta guía siempre está accesible desde el menú:"),
      RichTextSpan.newLine(context, lines: 2),
      ...RichTextSpan.icon(
        context,
        FontAwesomeIcons.cog,
        ThemeManager.getDrawerMenuItemIconColor(context),
        alignment: PlaceholderAlignment.middle,
        text: "Opciones",
        hideBrackets: true,
      ),
      RichTextSpan.text(context, ">", bold: true),
      ...RichTextSpan.icon(
        context,
        FontAwesomeIcons.solidQuestionCircle,
        ThemeManager.getDrawerMenuItemIconColor(context),
        alignment: PlaceholderAlignment.middle,
        text: "Ayuda",
        hideBrackets: true,
      ),
    ];
  }

  List<InlineSpan> _buildOptionsFinishText() {
    return [
      RichTextSpan.text(
        context,
        "Podés volver a ver esta",
        fontSize: SizeConfig.blockSizeVertical * 2.5,
        italic: true,
      ),
      RichTextSpan.newLine(context),
      RichTextSpan.text(
        context,
        "guía cuando quieras :)",
        fontSize: SizeConfig.blockSizeVertical * 2.5,
        italic: true,
      ),
    ];
  }
}
