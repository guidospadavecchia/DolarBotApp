import 'package:flutter/material.dart';

import '../../../classes/size_config.dart';
import '../../../classes/theme_manager.dart';

export 'package:dolarbot_app/classes/size_config.dart';
export 'package:dolarbot_app/classes/theme_manager.dart';
export 'package:flutter/material.dart';

abstract class StepBase extends StatelessWidget {
  final int stepIndex;
  final int totalStepCount;
  final String title;
  final bool showStep;

  const StepBase({
    Key? key,
    this.stepIndex = 0,
    required this.totalStepCount,
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
              horizontal: SizeConfig.blockSizeHorizontal * 2,
            ),
            child: Scrollbar(
              thumbVisibility: false,
              radius: Radius.circular(SizeConfig.blockSizeVertical),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 5),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowIndicator();
                    return false;
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      height: SizeConfig.screenHeight * 0.62,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: body(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        buildStepFooter(context, stepIndex, totalStepCount),
      ],
    );
  }

  List<Widget> body();
}

Widget buildStepHeader(BuildContext context, int step, String title, bool showStep) {
  double horizontalPadding = SizeConfig.blockSizeHorizontal * 8;
  double verticalPadding = SizeConfig.blockSizeVertical * 3;
  double stepSize = SizeConfig.blockSizeVertical * 5.5;
  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(left: showStep ? horizontalPadding * 2 : 0, top: verticalPadding, bottom: verticalPadding, right: horizontalPadding),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: SizeConfig.blockSizeVertical * 4,
          margin: EdgeInsets.only(left: horizontalPadding),
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
                fontSize: showStep ? SizeConfig.blockSizeVertical * 2 : SizeConfig.blockSizeVertical * 2.5,
                color: ThemeManager.getGlobalBackgroundColor(context),
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      if (showStep)
        Padding(
          padding: EdgeInsets.only(left: horizontalPadding, top: verticalPadding * 0.75, right: horizontalPadding),
          child: Container(
            width: stepSize,
            height: stepSize,
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

Widget buildStepFooter(BuildContext context, int stepIndex, int totalStepCount) {
  double stepBarWidth = SizeConfig.screenWidth / 1.5;
  double horizontalMargin = SizeConfig.screenWidth / 10;
  double verticalMargin = SizeConfig.blockSizeVertical * 3;
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
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
          width: stepBarWidth,
          height: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: ThemeManager.getPrimaryAccentColor(context),
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: verticalMargin),
          width: (stepBarWidth / totalStepCount) * (stepIndex.toDouble() + 1),
          height: 5,
        ),
      ],
    ),
  );
}
