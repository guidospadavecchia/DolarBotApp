import 'package:dolarbot_app/classes/size_config.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

export 'package:flutter/material.dart';
export 'package:dolarbot_app/classes/size_config.dart';
export 'package:dolarbot_app/classes/theme_manager.dart';

abstract class StepBase extends StatelessWidget {
  final int stepIndex;
  final String title;
  final bool showStep;

  const StepBase({
    Key? key,
    this.stepIndex = 0,
    required this.title,
    this.showStep = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildStepHeader(context, stepIndex, title, showStep),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical,
              horizontal: SizeConfig.blockSizeHorizontal * 8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...body(),
              ],
            ),
          ),
        ),
        buildStepFooter(context, stepIndex),
      ],
    );
  }

  List<Widget> body();
}

Widget buildStepHeader(BuildContext context, int step, String title, bool showStep) {
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(left: showStep ? 45 : 0, top: 22, bottom: 20, right: 20),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 35,
          margin: const EdgeInsets.only(left: 25),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
            color: ThemeManager.getPrimaryAccentColor(context),
          ),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: showStep ? 16 : 18,
                color: ThemeManager.getGlobalBackgroundColor(context),
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      if (showStep)
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ThemeManager.getPrimaryAccentColor(context),
            ),
            child: Center(
              child: Text(
                step.toString(),
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: SizeConfig.blockSizeVertical * 3.5,
                    color: ThemeManager.getGlobalBackgroundColor(context),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
    ],
  );
}

Widget buildStepFooter(BuildContext context, int stepIndex) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ThemeManager.getPrimaryAccentColor(context).withAlpha(100),
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
          width: 300,
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            color: ThemeManager.getPrimaryAccentColor(context),
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
          width: 35 * (stepIndex.toDouble() + 1),
          height: 10,
        ),
      ],
    ),
  );
}
