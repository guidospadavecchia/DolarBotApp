import 'package:flutter/material.dart';

class CardLastUpdated extends StatelessWidget {
  final String timestamp;

  const CardLastUpdated({
    Key key,
    @required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Icon(
                Icons.alarm,
                size: 16,
                color: Colors.white54,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 2),
                child: Text(
                  "Última actualización: $timestamp",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.normal,
                    color: Colors.white54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
