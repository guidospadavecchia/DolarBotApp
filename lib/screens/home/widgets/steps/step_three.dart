import 'package:dolarbot_app/screens/home/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepThree extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepThree(
    this.context, {
    this.stepIndex,
    @required this.title,
    @required this.showStep,
  }) : super(stepIndex: stepIndex, title: title, showStep: showStep);

  @override
  List<Widget> body() {
    return [
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(context,
                "¡Podés compartir cualquier cotización instantáneamente como una tarjeta, y por el medio que más te guste!\n\n"),
            writeText(context, "Pueden ser tanto las que están\nen tu "),
            writeIcon(FontAwesomeIcons.home,
                ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom),
            writeText(context, "  Inicio", isBold: true),
            writeText(context, " como las que no.")
          ],
        ),
      ),
      SizedBox(
        width: 256,
        height: 256,
        child: Image.asset(
          "assets/images/general/menu_share.png",
          width: 256,
          height: 256,
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(context, "Presioná "),
            writeIcon(Icons.share, ThemeManager.getPrimaryAccentColor(context)),
            writeText(context, " ya sea desde el menú "),
            writeIcon(
                Icons.more_horiz, ThemeManager.getPrimaryTextColor(context)),
            writeText(context, " de la cotización. O bien, desde la tarjeta."),
          ],
        ),
      ),
    ];
  }
}
