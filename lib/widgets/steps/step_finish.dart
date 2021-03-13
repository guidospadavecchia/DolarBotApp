import 'package:dolarbot_app/widgets/common/dialog_button.dart';
import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

class StepFinish extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;
  final bool isComingFromOptions;

  StepFinish(
    this.context, {
    this.stepIndex = 0,
    @required this.title,
    @required this.showStep,
    this.isComingFromOptions = false,
  }) : super(stepIndex: stepIndex, title: title, showStep: showStep);

  @override
  List<Widget> body() {
    return [
      SizedBox.shrink(),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(height: 1.3),
          children: [
            writeText(context, "¡Listo 👌!", fontSize: 40),
            writeNewLine(context, lines: 4),
            if (!isComingFromOptions)
              ..._buildFinishText()
            else
              ..._buildOptionsFinishText(),
          ],
        ),
      ),
      DialogButton(
          icon: Icons.check,
          text: "Entendido",
          onPressed: () {
            var settings = Hive.box('settings');
            settings
                .put('isFirstTime', false)
                .then((_) => Navigator.of(context).pop());
          }),
      SizedBox.shrink(),
    ];
  }

  List<InlineSpan> _buildFinishText() {
    return [
      writeText(
        context,
        "Ya podés comenzar a utilizar ",
        fontSize: 20,
      ),
      writeText(
        context,
        "DolarBot",
        bold: true,
        fontSize: 24,
      ),
      writeNewLine(context, lines: 3),
      writeText(context,
          "Recordá que esta guía siempre está accesible desde el menú:"),
      writeNewLine(context, lines: 2),
      ...writeIcon(
        context,
        FontAwesomeIcons.cog,
        ThemeManager.getDrawerMenuItemIconColor(context),
        alignment: PlaceholderAlignment.bottom,
        text: "Opciones",
        hideBrackets: true,
      ),
      writeText(context, ">", bold: true),
      ...writeIcon(
        context,
        FontAwesomeIcons.solidQuestionCircle,
        ThemeManager.getDrawerMenuItemIconColor(context),
        alignment: PlaceholderAlignment.bottom,
        text: "Ayuda",
        hideBrackets: true,
      ),
    ];
  }

  List<InlineSpan> _buildOptionsFinishText() {
    return [
      writeText(
        context,
        "Podés volver a ver esta",
        fontSize: 20,
        italic: true,
      ),
      writeNewLine(context),
      writeText(
        context,
        "guía cuando quieras :)",
        fontSize: 20,
        italic: true,
      ),
    ];
  }
}
