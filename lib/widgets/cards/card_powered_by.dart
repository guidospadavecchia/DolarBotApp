import 'package:dolarbot_app/classes/app_config.dart';
import 'package:flutter/material.dart';

class CardPoweredBy extends StatelessWidget {
  const CardPoweredBy({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Image.asset(
            AppConfig.logo.borderless,
            filterQuality: FilterQuality.high,
          ),
          width: 16,
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3, top: 2),
          child: Text(
            AppConfig.appDisplayName,
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
