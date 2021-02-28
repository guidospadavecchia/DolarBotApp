import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/material.dart';

class InputConverted extends StatelessWidget {
  final String title;
  final TextEditingController textController;

  const InputConverted({
    Key key,
    this.title,
    this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.normal,
            color: ThemeManager.getPrimaryTextColor(context),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: TextField(
            enabled: false,
            controller: textController,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 3),
              isDense: true,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
              color: ThemeManager.getPrimaryTextColor(context),
            ),
          ),
        ),
      ],
    );
  }
}
