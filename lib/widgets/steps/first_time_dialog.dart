import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../classes/size_config.dart';
import '../common/blur_dialog.dart';
import 'exports/step_exports.dart';
import 'step_five.dart';
import 'step_six.dart';

class FirstTimeDialog extends StatelessWidget {
  static const int _kTotalStepCount = 8;
  final bool dismissable;

  const FirstTimeDialog({
    Key? key,
    this.dismissable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: dismissable,
      child: BlurDialog(
        dialog: Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.8,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white10, width: 2),
              borderRadius: BorderRadius.circular(8),
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
              options: CarouselOptions(initialPage: 0, height: SizeConfig.screenHeight * 0.8, enableInfiniteScroll: false, viewportFraction: 1),
              items: [
                StepWelcome(
                  context,
                  stepIndex: 0,
                  totalStepCount: _kTotalStepCount,
                  title: "Bienvenido",
                  showStep: false,
                ),
                StepOne(
                  context,
                  stepIndex: 1,
                  totalStepCount: _kTotalStepCount,
                  title: "Favoritos",
                  showStep: true,
                ),
                StepTwo(
                  context,
                  stepIndex: 2,
                  totalStepCount: _kTotalStepCount,
                  title: "Inicio",
                  showStep: true,
                ),
                StepThree(
                  context,
                  stepIndex: 3,
                  totalStepCount: _kTotalStepCount,
                  title: "Compartir Cotización",
                  showStep: true,
                ),
                StepFour(
                  context,
                  stepIndex: 4,
                  totalStepCount: _kTotalStepCount,
                  title: "Ordenar Tarjetas",
                  showStep: true,
                ),
                StepFive(
                  context,
                  stepIndex: 5,
                  totalStepCount: _kTotalStepCount,
                  title: "Quitar Tarjetas",
                  showStep: true,
                ),
                StepSix(
                  context,
                  stepIndex: 6,
                  totalStepCount: _kTotalStepCount,
                  title: "Calculadora",
                  showStep: true,
                ),
                StepFinish(
                  context,
                  stepIndex: 7,
                  totalStepCount: _kTotalStepCount,
                  title: "¡Eso es todo!",
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
