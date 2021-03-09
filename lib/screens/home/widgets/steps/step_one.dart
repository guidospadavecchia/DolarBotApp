import 'package:dolarbot_app/screens/home/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepOne extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final String title;
  final bool showStep;

  StepOne(
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
                "Podés agregar tus cotizaciones a favoritos para que aparezcan en el [ "),
            writeIcon(FontAwesomeIcons.home,
                ThemeManager.getPrimaryTextColor(context),
                alignment: PlaceholderAlignment.bottom),
            writeText(context, "  Inicio", bold: true),
            writeText(context, " ]."),
          ],
        ),
      ),
      SizedBox(
        width: 256,
        height: 256,
        child: Image.asset(
          "assets/images/general/menu_fav.png",
          width: 256,
          height: 256,
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            writeText(context,
                "Para hacerlo, entrá a la cotización que quieras agregar, y tocá en el [ "),
            writeIcon(Icons.favorite_border_rounded, Colors.red),
            writeText(context, " ] que está dentro del menú [ "),
            writeIcon(
                Icons.more_horiz, ThemeManager.getPrimaryTextColor(context)),
            writeText(context, " ] en la parte inferior derecha."),
          ],
        ),
      ),
    ];
  }
}
