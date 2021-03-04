import 'package:flutter/material.dart';

class SimpleFabOption {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final Color splashColor;
  final String tooltip;
  final Function onPressed;

  const SimpleFabOption({
    @required this.icon,
    @required this.iconColor,
    @required this.backgroundColor,
    this.splashColor,
    this.tooltip,
    @required this.onPressed,
  });
}

class SimpleFabMenu extends StatefulWidget {
  final IconData icon;
  final IconData iconClose;
  final Color iconColor;
  final double iconSize;
  final Axis direction;
  final List<SimpleFabOption> items;
  final double childrenItemSize;
  final Color backGroundColor;
  final EdgeInsets padding;
  final double animationForce;

  const SimpleFabMenu({
    Key key,
    @required this.icon,
    this.iconClose = Icons.close,
    @required this.iconColor,
    this.iconSize = 64,
    @required this.direction,
    @required this.items,
    this.childrenItemSize = 44,
    @required this.backGroundColor,
    this.padding = EdgeInsets.zero,
    this.animationForce = 100,
  })  : assert(iconSize >= 60 && iconSize <= 90),
        assert(childrenItemSize >= 32 && childrenItemSize <= 60),
        super(key: key);

  @override
  SimpleFabMenuState createState() => SimpleFabMenuState();
}

class SimpleFabMenuState extends State<SimpleFabMenu>
    with SingleTickerProviderStateMixin {
  Animation<double> _listAnimation;
  AnimationController _animationController;
  bool _isOpen = false;
  bool _isAnimating = false;
  IconData _iconFab;

  bool get isOpen => _isOpen;

  void initState() {
    _iconFab = widget.icon;

    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _listAnimation =
        Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingContent = widget.direction == Axis.vertical
        ? EdgeInsets.symmetric(
            vertical: 15,
            horizontal: (widget.iconSize / 2) - (widget.childrenItemSize / 2))
        : EdgeInsets.symmetric(
            horizontal: (widget.iconSize / 2) - (widget.childrenItemSize / 2));
    return Padding(
      padding: widget.padding,
      child: Container(
        height: widget.direction == Axis.horizontal
            ? widget.iconSize
            : double.infinity,
        alignment: Alignment.bottomRight,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.end,
          alignment: widget.direction == Axis.horizontal
              ? WrapAlignment.center
              : WrapAlignment.end,
          direction: widget.direction == Axis.horizontal
              ? Axis.vertical
              : Axis.horizontal,
          children: [
            _SimpleFabMenuListAnimated(
              items: widget.items,
              size: widget.childrenItemSize,
              screenInset: _getScreenInset(),
              direction: widget.direction,
              padding: paddingContent,
              animation: _listAnimation,
            ),
            _FabCircularOption(
              direction: widget.direction,
              size: widget.iconSize,
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
    );
  }

  _getScreenInset() {
    return widget.direction == Axis.vertical
        ? MediaQuery.of(context).viewInsets.bottom + widget.animationForce
        : MediaQuery.of(context).viewInsets.right + widget.animationForce;
  }
}

class _SimpleFabMenuListAnimated extends AnimatedWidget {
  final List<SimpleFabOption> items;
  final Axis direction;
  final double screenInset;
  final EdgeInsets padding;
  final double size;

  const _SimpleFabMenuListAnimated({
    @required this.items,
    @required this.direction,
    @required double this.screenInset,
    @required this.padding,
    @required this.size,
    @required Animation animation,
  }) : super(listenable: animation);

  get _listAnimation => listenable;

  Widget buildItem(BuildContext context, int index) {
    double matrixTranslation = 1 *
        (screenInset - _listAnimation.value * screenInset) *
        ((items.length - index) / 4);

    final transform = Matrix4.translationValues(
      direction == Axis.horizontal ? matrixTranslation : 0,
      direction == Axis.vertical ? matrixTranslation : 0,
      0.0,
    );

    return Align(
      alignment: direction == Axis.vertical
          ? Alignment.centerRight
          : Alignment.centerLeft,
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
        separatorBuilder: (_, __) => SizedBox(height: 8, width: 8),
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
    Key key,
    @required this.size,
    @required this.item,
    this.direction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: RawMaterialButton(
        shape: CircleBorder(),
        fillColor: item.backgroundColor,
        splashColor: item.splashColor != null
            ? item.splashColor
            : Theme.of(context).splashColor,
        onPressed: item.onPressed,
        child: item.tooltip != null
            ? Tooltip(
                preferBelow: false,
                margin: direction == Axis.vertical
                    ? EdgeInsets.only(right: 80)
                    : EdgeInsets.zero,
                verticalOffset: direction == Axis.vertical ? -15 : size - 10,
                message: item.tooltip,
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
