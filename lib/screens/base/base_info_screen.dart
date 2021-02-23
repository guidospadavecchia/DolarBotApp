import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/screens/home/widgets/fab_menu/fab_menu.dart';
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

  BaseInfoScreen({
    Key key,
    this.title,
  }) : super(key: key);
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
      appBar: CoolAppBar(
        title: widget.title,
        isMainMenu: isMainMenu(),
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
      body: body(),
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
}
