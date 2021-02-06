import 'package:flutter/material.dart';

class DrawerMenuHeader extends StatelessWidget {
  const DrawerMenuHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Image(
            image: AssetImage('assets/images/dolar-logo.png'),
          ),
          width: 50,
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 9),
          child: Text(
            'DolarBot',
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey[800],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
