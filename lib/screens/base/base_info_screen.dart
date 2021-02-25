import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/screens/base/widgets/fab_menu/fab_menu.dart';
import 'package:dolarbot_app/widgets/common/cool_app_bar.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

export 'package:dolarbot_app/api/api.dart';
export 'package:dolarbot_app/api/responses/base/apiResponse.dart';
export 'package:dolarbot_app/widgets/common/future_screen_delegate/future_screen_delegate.dart';
export 'package:dolarbot_app/widgets/currency_info/currency_info_container.dart';
export 'package:flutter/material.dart';
export 'package:provider/provider.dart';

abstract class BaseInfoScreen extends StatefulWidget {
  final String title;
  final String headerTitle;
  final String headerIconAsset;
  final IconData headerIconData;
  final List<Color> gradiantColors;

  BaseInfoScreen({
    Key key,
    this.title,
    this.headerTitle,
    this.headerIconAsset,
    this.headerIconData,
    this.gradiantColors,
  })  : assert(headerIconAsset == null || headerIconData == null),
        super(key: key);
}

abstract class BaseInfoScreenState<Page extends BaseInfoScreen>
    extends State<BaseInfoScreen> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  bool isMainMenu() => true;
  bool showRefreshButton() => true;
  bool showFabMenu() => true;
  bool showShareButton() => true;
  bool showClipboardButton() => true;
  bool showCalculatorButton() => true;
  bool extendBodyBehindAppBar() => true;
  Color setColorAppbar() => ThemeManager.getPrimaryTextColor(context);
}

mixin BaseScreen<Page extends BaseInfoScreen> on BaseInfoScreenState<Page> {
  bool shouldForceRefresh = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ActiveScreenData>(context, listen: false)
          .setActiveTitle(widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar(),
      appBar: CoolAppBar(
        title: widget.title,
        isMainMenu: isMainMenu(),
        foregroundColor: setColorAppbar(),
        showRefreshButton: showRefreshButton(),
        onRefresh: () => _refresh(),
      ),
      drawer: Container(
        width: 290,
        child: Drawer(
          child: DrawerMenu(
            onDrawerDisplayChanged: (isOpen) => _onDrawerDisplayChange(isOpen),
          ),
        ),
      ),
      drawerEdgeDragWidth: 200,
      drawerEnableOpenDragGesture: true,
      body: (widget.headerTitle != null || isMainMenu())
          ? Container(
              padding: widget.headerTitle != null
                  ? EdgeInsets.only(top: 105)
                  : EdgeInsets.only(top: 0),
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.gradiantColors == null
                      ? [
                          ThemeManager.getGlobalBackgroundColor(context),
                          ThemeManager.getGlobalBackgroundColor(context),
                        ]
                      : widget.gradiantColors,
                ),
              ),
              child: Wrap(
                runAlignment: widget.headerTitle != null
                    ? WrapAlignment.start
                    : WrapAlignment.center,
                runSpacing: 0,
                children: [
                  header(),
                  body(),
                ],
              ),
            )
          : body(),
      floatingActionButton: showFabMenu()
          ? FabMenu(
              fabKey: fabKey,
              showShareButton: showShareButton(),
              showClipboardButton: showClipboardButton(),
              showCalculatorButton: showCalculatorButton(),
            )
          : null,
    );
  }

  void _onDrawerDisplayChange(bool isOpen) {
    if (isOpen && (fabKey?.currentState?.isOpen ?? false)) {
      fabKey.currentState.close();
    }
  }

  void _refresh() {
    setState(() {
      shouldForceRefresh = true;
    });
  }

  void setActiveData(ApiResponse data, String shareText) {
    ActiveScreenData activeScreenData =
        Provider.of<ActiveScreenData>(context, listen: false);
    activeScreenData.setActiveData(data, shareText);
  }

  Widget body();

  Widget header() {
    if (widget.headerTitle != null) {
      return Container(
        color: Colors.black12,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.headerIconAsset != null
                ? Container(
                    child: Image.asset(
                      widget.headerIconAsset,
                      width: 36,
                      height: 36,
                      filterQuality: FilterQuality.high,
                      color: Colors.white,
                    ),
                  )
                : Container(
                    child: Icon(
                      widget.headerIconData,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
            SizedBox(width: 20),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7),
              child: FittedBox(
                fit: widget.headerTitle.length > 10
                    ? BoxFit.fitWidth
                    : BoxFit.none,
                child: Text(
                  widget.headerTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
