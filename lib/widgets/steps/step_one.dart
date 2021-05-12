import 'package:dolarbot_app/widgets/common/rich_text_span/rich_text_span.dart';
import 'package:dolarbot_app/widgets/steps/base/step_base.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepOne extends StepBase {
  final BuildContext context;
  final int stepIndex;
  final int totalStepCount;
  final String title;
  final bool showStep;

  StepOne(
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
                "Podés agregar tus cotizaciones a favoritos para que aparezcan en la pantalla principal: El"),
            ...RichTextSpan.icon(
              context,
              FontAwesomeIcons.home,
              ThemeManager.getPrimaryTextColor(context),
              alignment: PlaceholderAlignment.bottom,
              text: " Inicio",
            ),
          ],
        ),
      ),
      SizedBox(
        width: SizeConfig.screenWidth / 1.5,
        child: Image.asset(
          "assets/images/general/menu_fav.png",
          filterQuality: FilterQuality.high,
        ),
      ),
      RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            RichTextSpan.text(
                context, "Para hacerlo, entrá a la cotización que quieras agregar, y tocá en el"),
            ...RichTextSpan.icon(
              context,
              Icons.favorite_border_rounded,
              Colors.red,
            ),
            RichTextSpan.text(context, "que está dentro del menú"),
            ...RichTextSpan.icon(
              context,
              Icons.more_horiz,
              ThemeManager.getPrimaryTextColor(context),
            ),
            RichTextSpan.text(context, "en la parte inferior derecha."),
          ],
        ),
      ),
    ];
  }
}
