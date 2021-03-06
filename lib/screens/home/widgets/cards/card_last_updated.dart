import 'package:flutter/material.dart';
import 'package:dolarbot_app/util/extensions/datetime_extensions.dart';

class CardLastUpdated extends StatelessWidget {
  final String timestamp;

  const CardLastUpdated({
    Key key,
    @required this.timestamp,
  }) : super(key: key);

  String _getFormattedDateTime() {
    return DateTime.parse(timestamp.replaceAll('/', '-')).toLongDateString();
  }

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
                  "Última actualización: ${_getFormattedDateTime()}",
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
