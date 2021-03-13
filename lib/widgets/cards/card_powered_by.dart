import 'package:flutter/material.dart';

class CardPoweredBy extends StatelessWidget {
  const CardPoweredBy({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3, top: 2, right: 3),
          child: Text(
            "Powered by",
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          child: Image.asset(
            "assets/images/logos/borderless/logo.png",
            filterQuality: FilterQuality.high,
          ),
          width: 16,
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 3, top: 2),
          child: Text(
            "DolarBot",
            style: TextStyle(
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
