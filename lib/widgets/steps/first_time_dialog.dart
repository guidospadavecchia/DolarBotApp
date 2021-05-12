import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/widgets/common/blur_dialog.dart';
import 'package:dolarbot_app/widgets/steps/exports/step_exports.dart';
import 'package:dolarbot_app/widgets/steps/step_five.dart';
import 'package:dolarbot_app/widgets/steps/step_six.dart';
import 'package:flutter/material.dart';

class FirstTimeDialog extends StatelessWidget {
  final bool dismissable;

  const FirstTimeDialog({
    Key? key,
    this.dismissable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => dismissable,
      child: BlurDialog(
        dialog: Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.8,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white10, width: 2),
              borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical),
              gradient: AdaptiveTheme.of(context).brightness == Brightness.dark
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromRGBO(14, 24, 29, 1),
                        const Color.fromRGBO(14, 24, 29, 0.4),
                      ],
                    )
                  : null,
            ),
            child: CarouselSlider(
              options: CarouselOptions(
                  initialPage: 0,
                  height: SizeConfig.screenHeight * 0.8,
                  enableInfiniteScroll: false,
                  viewportFraction: 1),
              items: [
                StepWelcome(
                  context,
                  stepIndex: 0,
                  title: "Bienvenido",
                  showStep: false,
                ),
                StepOne(
                  context,
                  stepIndex: 1,
                  title: "Favoritos",
                  showStep: true,
                ),
                StepTwo(
                  context,
                  stepIndex: 2,
                  title: "Inicio",
                  showStep: true,
                ),
                StepThree(
                  context,
                  stepIndex: 3,
                  title: "Compartir Cotización",
                  showStep: true,
                ),
                StepFour(
                  context,
                  stepIndex: 4,
                  title: "Ordenar Tarjetas",
                  showStep: true,
                ),
                StepFive(
                  context,
                  stepIndex: 5,
                  title: "Quitar Tarjetas",
                  showStep: true,
                ),
                StepSix(
                  context,
                  stepIndex: 6,
                  title: "Calculadora",
                  showStep: true,
                ),
                StepFinish(
                  context,
                  stepIndex: 7,
                  title: "Eso es todo",
                  showStep: false,
                  isComingFromOptions: dismissable,
                )
              ].map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return i;
                    },
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
