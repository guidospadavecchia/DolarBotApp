import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  final String title;
  final bool showButtons;
  final Function onTapShare;
  final Function onTapFavorite;

  const CardHeader({
    Key key,
    this.title,
    this.showButtons = true,
    this.onTapShare,
    this.onTapFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
        if (showButtons)
          GestureDetector(
            onTap: onTapShare,
            child: Tooltip(
              preferBelow: false,
              message: "Compartir 📲",
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 15),
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (showButtons)
          GestureDetector(
            onTap: onTapFavorite,
            child: Tooltip(
              preferBelow: false,
              message: "Quitar de favoritos 💔",
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
