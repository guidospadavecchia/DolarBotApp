import 'package:dolarbot_app/screens/home/widgets/steps/base/step_base.dart';
import 'package:dolarbot_app/widgets/common/dialog_button.dart';
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
            writeText(context, "¡Gracias 🤙!", fontSize: 40),
            writeText(context, "\n\n\n\n"),
            if (!isComingFromOptions)
              ..._buildFinishText()
            else
              writeText(
                context,
                "Y volvé cuando quieras.",
                fontSize: 20,
              ),
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
        isBold: true,
        fontSize: 20,
      ),
      writeText(context,
          ".\n\n\nRecordá que esta ayuda está accesible desde el menú "),
      writeIcon(
        FontAwesomeIcons.cog,
        ThemeManager.getDrawerMenuItemIconColor(context),
        alignment: PlaceholderAlignment.bottom,
      ),
      writeText(context, " Opciones > ", isBold: true),
      writeIcon(
        FontAwesomeIcons.solidQuestionCircle,
        ThemeManager.getDrawerMenuItemIconColor(context),
        alignment: PlaceholderAlignment.bottom,
      ),
      writeText(context, " Ayuda", isBold: true),
    ];
  }
}
