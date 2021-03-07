import 'package:dolarbot_app/screens/home/widgets/cards/card_powered_by.dart';
import 'package:flutter/material.dart';
import 'package:dolarbot_app/util/extensions/datetime_extensions.dart';

class CardLastUpdated extends StatelessWidget {
  final String timestamp;
  final bool showPoweredBy;

  const CardLastUpdated({
    Key key,
    @required this.timestamp,
    this.showPoweredBy = true,
  }) : super(key: key);

  String _getFormattedDateTime() {
    return DateTime.parse(timestamp.replaceAll('/', '-')).toLongDateString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.alarm,
                      size: 16,
                      color: Colors.white54,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: Text(
                        showPoweredBy
                            ? "${_getFormattedDateTime()}"
                            : "Última actualización: ${_getFormattedDateTime()}",
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
                if (showPoweredBy)
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CardPoweredBy(),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
