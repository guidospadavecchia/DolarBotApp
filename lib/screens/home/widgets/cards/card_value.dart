import 'package:flutter/material.dart';

class CardValue extends StatelessWidget {
  final String title;
  final double value;
  final String symbol;

  const CardValue({
    Key key,
    @required this.title,
    @required this.value,
    @required this.symbol,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        Text(
          "$symbol $value",
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
