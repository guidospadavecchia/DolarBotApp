import 'package:dolarbot_app/classes/size_config.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class SimpleFabOption {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color? splashColor;
  final String? tooltip;
  final VoidCallback onPressed;

  const SimpleFabOption({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    this.splashColor,
    this.tooltip,
    required this.onPressed,
  });
}

class SimpleFabMenu extends StatefulWidget {
  final IconData icon;
  final IconData iconClose;
  final Color iconColor;
  final double? iconSize;
  final Axis direction;
  final List<SimpleFabOption> items;
  final double? childrenItemSize;
  final Color backGroundColor;
  final EdgeInsets padding;
  final double animationForce;
  final Function? onOpened;
  final Function? onClosed;
  final bool visible;
  final bool showInitialAnimation;

  const SimpleFabMenu({
    Key? key,
    required this.icon,
    this.iconClose = Icons.close,
    required this.iconColor,
    this.iconSize,
    required this.direction,
    required this.items,
    this.childrenItemSize,
    required this.backGroundColor,
    this.padding = EdgeInsets.zero,
    this.animationForce = 100,
    this.onOpened,
    this.onClosed,
    this.visible = true,
    this.showInitialAnimation = true,
  }) : super(key: key);

  @override
  SimpleFabMenuState createState() => SimpleFabMenuState();
}

class SimpleFabMenuState extends State<SimpleFabMenu> with SingleTickerProviderStateMixin {
  late Animation<double> _listAnimation;
  late AnimationController _animationController;
  bool _isOpen = false;
  bool _isAnimating = false;
  late bool _visible;
  late IconData _iconFab;

  bool get isOpen => _isOpen;

  void initState() {
    super.initState();
    _iconFab = widget.icon;
    _visible = widget.visible;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _listAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void show() {
    if (!_visible) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => setState(() => _visible = true),
      );
    }
  }

  void hide() {
    if (_visible) {
      WidgetsBinding.instance!.addPostFrameCallback(
        (_) => setState(() => _visible = false),
      );
    }
  }

  void closeMenu() {
    _isAnimating = true;
    _animationController.reverse().then((_) {
      _isAnimating = false;
      _isOpen = false;
      setState(() {
        _iconFab = widget.icon;
      });
    });

    if (widget.onClosed != null) {
      widget.onClosed!();
    }
  }

  void openMenu() {
    _isAnimating = true;
    _animationController.forward().then((_) {
      _isAnimating = false;
      _isOpen = true;
      setState(() {
        _iconFab = widget.iconClose;
      });
    });

    if (widget.onOpened != null) {
      widget.onOpened!();
    }
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = widget.iconSize ?? SizeConfig.blockSizeVertical * 7.5;
    double childrenItemSize = widget.childrenItemSize ?? SizeConfig.blockSizeVertical * 5;

    if (_visible) {
      EdgeInsets paddingContent = widget.direction == Axis.vertical
          ? EdgeInsets.symmetric(
              vertical: SizeConfig.blockSizeVertical * 1.5,
              horizontal: (iconSize / 2) - (childrenItemSize / 2))
          : EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2);
      return PlayAnimation<double>(
        tween: Tween(begin: widget.showInitialAnimation ? SizeConfig.screenHeight : 0, end: 0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        builder: (context, child, value) {
          return Transform.translate(
            offset: Offset(0, value),
            child: child,
          );
        },
        child: Padding(
          padding: widget.padding,
          child: Container(
            height: widget.direction == Axis.horizontal ? iconSize : double.infinity,
            alignment: Alignment.bottomRight,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              alignment:
                  widget.direction == Axis.horizontal ? WrapAlignment.center : WrapAlignment.end,
              direction: widget.direction == Axis.horizontal ? Axis.vertical : Axis.horizontal,
              children: [
                _SimpleFabMenuListAnimated(
                  items: widget.items,
                  size: childrenItemSize,
                  screenInset: _getScreenInset(),
                  direction: widget.direction,
                  padding: paddingContent,
                  animation: _listAnimation,
                ),
                _FabCircularOption(
                  direction: widget.direction,
                  size: iconSize,
                  item: SimpleFabOption(
                    backgroundColor: widget.backGroundColor,
                    icon: _iconFab,
                    iconColor: widget.iconColor,
                    onPressed: () {
                      if (_isAnimating) return;
                      if (_isOpen) {
                        closeMenu();
                      } else {
                        openMenu();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  _getScreenInset() {
    return widget.direction == Axis.vertical
        ? SizeConfig.viewInsets.bottom + widget.animationForce
        : SizeConfig.viewInsets.right + widget.animationForce;
  }
}

class _SimpleFabMenuListAnimated extends AnimatedWidget {
  final List<SimpleFabOption> items;
  final Axis direction;
  final double screenInset;
  final EdgeInsets padding;
  final double size;

  const _SimpleFabMenuListAnimated({
    required this.items,
    required this.direction,
    required double this.screenInset,
    required this.padding,
    required this.size,
    required Animation animation,
  }) : super(listenable: animation);

  get _listAnimation => listenable;

  Widget buildItem(BuildContext context, int index) {
    double matrixTranslation =
        1 * (screenInset - _listAnimation.value * screenInset) * ((items.length - index) / 4);

    final transform = Matrix4.translationValues(
      direction == Axis.horizontal ? matrixTranslation : 0,
      direction == Axis.vertical ? matrixTranslation : 0,
      0.0,
    );

    return Align(
      alignment: direction == Axis.vertical ? Alignment.centerRight : Alignment.centerLeft,
      child: Transform(
        transform: transform,
        child: Opacity(
          opacity: _listAnimation.value,
          child: _FabCircularOption(
            size: size,
            item: items[index],
            direction: direction,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _listAnimation.value == 0,
      child: ListView.separated(
        scrollDirection: direction,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int i) => SizedBox(
            height: SizeConfig.blockSizeVertical * 1.5,
            width: SizeConfig.blockSizeHorizontal * 1.5),
        padding: padding,
        itemCount: items.length,
        itemBuilder: buildItem,
      ),
    );
  }
}

class _FabCircularOption extends StatelessWidget {
  final double size;
  final SimpleFabOption item;
  final Axis direction;

  const _FabCircularOption({
    Key? key,
    required this.size,
    required this.item,
    this.direction = Axis.vertical,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: RawMaterialButton(
        shape: CircleBorder(),
        fillColor: item.backgroundColor,
        splashColor: item.splashColor != null ? item.splashColor : Theme.of(context).splashColor,
        onPressed: () => item.onPressed(),
        child: item.tooltip != null
            ? Tooltip(
                preferBelow: false,
                margin: direction == Axis.vertical
                    ? EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 20)
                    : EdgeInsets.zero,
                verticalOffset: direction == Axis.vertical ? -15 : size,
                message: item.tooltip!,
                child: Icon(
                  item.icon,
                  size: size / 2,
                  color: item.iconColor,
                ),
              )
            : Icon(
                item.icon,
                size: size / 2,
                color: item.iconColor,
              ),
      ),
    );
  }
}
