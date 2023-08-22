import '../../common/icon_fonts.dart';
import '../base_info_screen.dart';
import '../../../widgets/common/simple_fab_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef FavoriteFunction = Future<bool> Function();

class FabMenu extends StatefulWidget {
  final GlobalKey<SimpleFabMenuState> simpleFabKey;
  final bool showFavoriteButton;
  final FavoriteFunction? onFavoriteButtonTap;
  final bool isFavorite;
  final bool showShareButton;
  final Function? onShareButtonTap;
  final bool showClipboardButton;
  final Function? onClipboardButtonTap;
  final bool showCalculatorButton;
  final Function? onCalculatorButtonTap;
  final bool showDescriptionButton;
  final Function? onShowDescriptionTap;
  final bool showHistoricalChartButton;
  final Function? onHistoricalChartButtonTap;
  final Function? onOpened;
  final Function? onClosed;
  final bool visible;
  final Axis direction;

  const FabMenu({
    Key? key,
    required this.simpleFabKey,
    this.showFavoriteButton = false,
    this.onFavoriteButtonTap,
    this.isFavorite = false,
    this.showShareButton = false,
    this.onShareButtonTap,
    this.showClipboardButton = false,
    this.onClipboardButtonTap,
    this.showCalculatorButton = false,
    this.onCalculatorButtonTap,
    this.showDescriptionButton = false,
    this.onShowDescriptionTap,
    this.showHistoricalChartButton = false,
    this.onHistoricalChartButtonTap,
    this.onOpened,
    this.onClosed,
    this.visible = true,
    required this.direction,
  }) : super(key: key);

  @override
  _FabMenuState createState() => _FabMenuState();
}

class _FabMenuState extends State<FabMenu> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleFabMenu(
      key: widget.simpleFabKey,
      direction: widget.direction,
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
            iconColor: Colors.blue[800]!,
            backgroundColor: Colors.white,
            icon: IconFonts.info,
            onPressed: () {
              if (widget.onHistoricalChartButtonTap != null) {
                widget.onShowDescriptionTap!();
              }
              closeFabMenu();
            },
          ),
        if (widget.showClipboardButton)
          SimpleFabOption(
            tooltip: "Copiar al portapapeles 📝",
            iconColor: Colors.brown[600]!,
            backgroundColor: Colors.white,
            icon: Icons.copy,
            onPressed: () {
              if (widget.onClipboardButtonTap != null) {
                widget.onClipboardButtonTap!();
              }
              closeFabMenu();
            },
          ),
        if (widget.showCalculatorButton)
          SimpleFabOption(
            tooltip: "Calculadora 💱",
            iconColor: Colors.blueGrey[700]!,
            backgroundColor: Colors.white,
            icon: FontAwesomeIcons.calculator,
            onPressed: () {
              if (widget.onCalculatorButtonTap != null) {
                widget.onCalculatorButtonTap!();
              }
              closeFabMenu();
            },
          ),
        if (widget.showHistoricalChartButton)
          SimpleFabOption(
            tooltip: "Gráfico histórico 📈",
            iconColor: Colors.deepOrange[800]!,
            backgroundColor: Colors.white,
            icon: FontAwesomeIcons.chartBar,
            onPressed: () {
              if (widget.onHistoricalChartButtonTap != null) {
                widget.onHistoricalChartButtonTap!();
              }
              closeFabMenu();
            },
          ),
        if (widget.showShareButton)
          SimpleFabOption(
              tooltip: "Compartir 📲",
              iconColor: Colors.green[700]!,
              backgroundColor: Colors.white,
              icon: IconFonts.share,
              onPressed: () {
                closeFabMenu();
                if (widget.onShareButtonTap != null) {
                  widget.onShareButtonTap!();
                }
              }),
        if (widget.showFavoriteButton)
          SimpleFabOption(
            tooltip: isFavorite ? "Quitar de Favoritos 💔" : "Agregar a Favoritos ❤",
            iconColor: Colors.red[400]!,
            backgroundColor: Colors.white,
            icon: isFavorite ? IconFonts.heart : IconFonts.heart_empty,
            onPressed: () async {
              if (widget.onFavoriteButtonTap != null) {
                bool result = await widget.onFavoriteButtonTap!();
                setState(() => isFavorite = result);
                Future.delayed(const Duration(milliseconds: 200), () => closeFabMenu());
              }
            },
          ),
      ],
    );
  }

  void closeFabMenu() {
    if (widget.simpleFabKey.currentState?.isOpen ?? false) {
      widget.simpleFabKey.currentState!.closeMenu();
    }
  }
}
