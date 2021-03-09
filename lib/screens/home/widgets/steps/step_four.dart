import 'package:dolarbot_app/screens/home/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepFour extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepFour(
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
                "Pensamos en todo. Por eso, si querés realizar conversiones de"),
            writeText(context, " AR\$ ", isBold: true),
            writeIcon(
                Icons.compare_arrows, ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom),
            writeText(context, " US\$", isBold: true),
            writeText(context, ",\n de"),
            writeText(context, " AR\$ ", isBold: true),
            writeIcon(
                Icons.compare_arrows, ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom),
            writeText(context, " €", isBold: true),
            writeText(context, ", o incluso de"),
            writeText(context, " AR\$ ", isBold: true),
            writeIcon(
                Icons.compare_arrows, ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom),
            writeText(context, " BTC", isBold: true),
            writeText(context,
                ", podés hacerlo con la calculadora integrada en cada cotización."),
          ],
        ),
      ),
      SizedBox(
        height: 256,
        child: Image.asset(
          "assets/images/general/menu_calc.png",
          height: 256,
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(context, "Presioná "),
            writeIcon(FontAwesomeIcons.calculator,
                ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom),
            writeText(context, " en el menú "),
            writeIcon(
                Icons.more_horiz, ThemeManager.getPrimaryTextColor(context)),
            writeText(context,
                " de la cotización para abrir la calculadora y empezar a realizar tus conversiones 💱."),
          ],
        ),
      ),
    ];
  }
}
