import 'package:dolarbot_app/widgets/cards/card_powered_by.dart';
import 'package:flutter/material.dart';
import 'package:dolarbot_app/util/extensions/datetime_extensions.dart';

class CardLastUpdated extends StatefulWidget {
  final String timestamp;
  final bool showPoweredBy;

  const CardLastUpdated({
    Key key,
    @required this.timestamp,
    this.showPoweredBy = true,
  }) : super(key: key);

  @override
  _CardLastUpdatedState createState() => _CardLastUpdatedState();
}

class _CardLastUpdatedState extends State<CardLastUpdated> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.index == 0) {
      setState(() {});
    }
  }

  String _getFormattedDateTime() {
    if (widget.showPoweredBy) {
      return widget.timestamp != null
          ? DateTime.parse(widget.timestamp.replaceAll('/', '-')).toLongDateString()
          : DateTime.now().toLongDateString();
    }

    return widget.timestamp != null
        ? DateTime.parse(widget.timestamp.replaceAll('/', '-')).toRelativeString()
        : DateTime.now().toRelativeString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 5, right: widget.showPoweredBy ? 0 : 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.alarm,
                      size: 16,
                      color: Colors.white54,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 0),
                      child: Text(
                        widget.showPoweredBy
                            ? "${_getFormattedDateTime()}"
                            : "Última actualización: ${_getFormattedDateTime()}",
                        style: TextStyle(
                          fontSize: widget.showPoweredBy ? 11 : 12,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.normal,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (widget.showPoweredBy)
          Padding(
            padding: const EdgeInsets.only(top: 5, right: 15),
            child: CardPoweredBy(),
          ),
      ],
    );
  }
}
