import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  final String title;
  final bool showButtons;
  final Function onSharePressed;

  const CardHeader({
    Key key,
    this.title,
    this.showButtons = true,
    this.onSharePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 9,
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 7,
                    color: Colors.black54,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ),
        Opacity(
          opacity: showButtons ? 1 : 0,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Tooltip(
                  preferBelow: false,
                  message: "Compartir 📲",
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    constraints: BoxConstraints(minWidth: 0, minHeight: 0),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.all(5),
                    onPressed: onSharePressed,
                    child: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
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
