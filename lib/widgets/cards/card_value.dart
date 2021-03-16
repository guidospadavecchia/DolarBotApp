import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:tuple/tuple.dart';

enum Spacing { none, small, medium, large }

class CardValue extends StatelessWidget {
  final String title;
  final String value;
  final String symbol;
  final TextDirection textDirection;
  final Axis direction;
  final WrapCrossAlignment crossAlignment;
  final double valueSize;
  final double titleSize;
  final Spacing spaceBetweenTitle;
  final Spacing spaceMainAxisEnd;
  final bool hideDecimals;
  final Tuple2<intl.NumberFormat, String> numberFormat;

  const CardValue({
    Key key,
    @required this.title,
    @required this.value,
    @required this.symbol,
    this.textDirection = TextDirection.ltr,
    this.direction = Axis.vertical,
    this.crossAlignment = WrapCrossAlignment.start,
    this.valueSize = 18,
    this.titleSize = 14,
    this.spaceBetweenTitle = Spacing.none,
    this.spaceMainAxisEnd = Spacing.none,
    this.hideDecimals = false,
    this.numberFormat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String value = _getFormatedValue(numberFormat.item1, numberFormat.item2);

    return Wrap(
      spacing: _getSpaceMainAxisEnd(),
      children: [
        Wrap(
          crossAxisAlignment: crossAlignment,
          textDirection: textDirection,
          direction: direction,
          spacing: _getSpaceBetweenTitle(),
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: titleSize,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.black54,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            Text(
              value.trimLeft(),
              style: TextStyle(
                fontSize: valueSize,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 7,
                    color: Colors.black54,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ],
        ),
        direction == Axis.vertical
            ? SizedBox(height: _getSpaceMainAxisEnd() * 2)
            : SizedBox.shrink(),
      ],
    );
  }

  String _getFormatedValue(intl.NumberFormat numberFormat, String decimalSeparator) {
    if (value.isNumeric()) {
      String formattedNumber = numberFormat.format(double.parse(value));
      List<String> splittedFormattedNumber = formattedNumber.split(decimalSeparator);

      if (splittedFormattedNumber.length == 2 && hideDecimals) {
        return "$symbol ${splittedFormattedNumber[0]}";
      }
      return "$symbol ${formattedNumber}";
    } else {
      return "N/A";
    }
  }

  double _getSpaceBetweenTitle() {
    double spaceSize;

    switch (spaceBetweenTitle) {
      case Spacing.none:
        spaceSize = 0;
        break;
      case Spacing.small:
        spaceSize = 5;
        break;
      case Spacing.medium:
        spaceSize = 10;
        break;
      case Spacing.large:
        spaceSize = 15;
        break;
    }

    return spaceSize;
  }

  double _getSpaceMainAxisEnd() {
    double spaceSize;

    switch (spaceMainAxisEnd) {
      case Spacing.none:
        spaceSize = 10;
        break;
      case Spacing.small:
        spaceSize = 15;
        break;
      case Spacing.medium:
        spaceSize = 20;
        break;
      case Spacing.large:
        spaceSize = 25;
        break;
    }

    return spaceSize;
  }
}
