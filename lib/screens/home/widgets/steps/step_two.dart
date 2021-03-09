import 'package:dolarbot_app/screens/home/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepTwo extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepTwo(
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
                "Las cotizaciones que agregues aparecerán una debajo de la otra en formato de "),
            writeText(context, "tarjetas", isBold: true),
            writeText(context,
                " super cool 😎.\n\n¡Y no hay límite!\nPodés agregar todas las que quieras."),
          ],
        ),
      ),
      SizedBox(
        width: 256,
        child: Image.asset(
          "assets/images/general/home_bg.png",
          width: 256,
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(context,
                "También podés quitarlas, claro.\n\nSimplemente tocá en la "),
            writeIcon(FontAwesomeIcons.times, Colors.red),
            writeText(context, " que está ubicada en la tarjeta."),
          ],
        ),
      ),
    ];
  }
}
