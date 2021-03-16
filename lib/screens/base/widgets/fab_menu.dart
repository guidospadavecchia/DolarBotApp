import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/common/simple_fab_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart' as share2;

typedef FavoriteFunction = Future<bool> Function();

class FabMenu extends StatefulWidget {
  final GlobalKey<SimpleFabMenuState> simpleFabKey;
  final bool showFavoriteButton;
  final FavoriteFunction onFavoriteButtonTap;
  final bool isFavorite;
  final bool showShareButton;
  final Function onShareButtonTap;
  final bool showClipboardButton;
  final Function onClipboardButtonTap;
  final bool showCalculatorButton;
  final Function onCalculatorButtonTap;
  final bool showDescriptionButton;
  final Function onShowDescriptionTap;
  final Function onOpened;
  final Function onClosed;
  final bool visible;

  const FabMenu({
    Key key,
    this.simpleFabKey,
    this.showFavoriteButton = true,
    this.onFavoriteButtonTap,
    this.isFavorite = false,
    this.showShareButton = true,
    this.onShareButtonTap,
    this.showClipboardButton = true,
    this.onClipboardButtonTap,
    this.showCalculatorButton = true,
    this.onCalculatorButtonTap,
    this.showDescriptionButton = false,
    this.onShowDescriptionTap,
    this.onOpened,
    this.onClosed,
    this.visible = true,
  }) : super(key: key);

  @override
  _FabMenuState createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> {
  bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleFabMenu(
      key: widget.simpleFabKey,
      direction: Axis.horizontal,
      icon: Icons.more_horiz,
      iconColor: Colors.black87,
      backGroundColor: Colors.white,
      onOpened: widget.onOpened,
      onClosed: widget.onClosed,
      visible: widget.visible,
      items: <SimpleFabOption>[
        if (widget.showDescriptionButton)
          SimpleFabOption(
            tooltip: "Ver descripción 📖",
            iconColor: Colors.black87,
            backgroundColor: Colors.white,
            icon: FontAwesomeIcons.question,
            onPressed: () {
              widget.onShowDescriptionTap();
              closeFabMenu();
            },
          ),
        if (widget.showClipboardButton)
          SimpleFabOption(
            tooltip: "Copiar al portapapeles 📝",
            iconColor: Colors.black87,
            backgroundColor: Colors.white,
            icon: Icons.copy,
            onPressed: () {
              widget.onClipboardButtonTap();
              closeFabMenu();
            },
          ),
        if (widget.showCalculatorButton)
          SimpleFabOption(
            tooltip: "Calculadora 💱",
            iconColor: Colors.black87,
            backgroundColor: Colors.white,
            icon: FontAwesomeIcons.calculator,
            onPressed: () {
              widget.onCalculatorButtonTap();
              closeFabMenu();
            },
          ),
        if (widget.showShareButton)
          SimpleFabOption(
              tooltip: "Compartir 📲",
              iconColor: Colors.green[700],
              backgroundColor: Colors.white,
              icon: Icons.share,
              onPressed: () {
                closeFabMenu();
                widget.onShareButtonTap();
              }),
        if (widget.showFavoriteButton)
          SimpleFabOption(
            tooltip: "Agregar a Favoritos ❤",
            iconColor: Colors.red[400],
            backgroundColor: Colors.white,
            icon: isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
            onPressed: () async {
              bool result = await widget.onFavoriteButtonTap();
              setState(() => isFavorite = result);
              Future.delayed(Duration(milliseconds: 200), () => closeFabMenu());
            },
          ),
      ],
    );
  }

  void closeFabMenu() {
    if (widget.simpleFabKey?.currentState?.isOpen ?? false) {
      widget.simpleFabKey.currentState.closeMenu();
    }
  }

  void share(String text, {String title}) {
    share2.Share.share(text, subject: title != null ? 'Cotización $title' : '');
    closeFabMenu();
  }
}
