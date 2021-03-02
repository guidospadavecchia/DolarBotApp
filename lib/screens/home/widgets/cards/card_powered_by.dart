import 'package:flutter/material.dart';

class CardPoweredBy extends StatelessWidget {
  const CardPoweredBy({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Divider(endIndent: 5, color: Colors.white24),
                ),
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
                Opacity(
                  opacity: 1,
                  child: SizedBox(
                    child: Image.asset(
                      "assets/images/logos/borderless/logo.png",
                      filterQuality: FilterQuality.high,
                    ),
                    width: 16,
                    height: 16,
                  ),
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
            ),
          ),
        ),
      ],
    );
  }
}
