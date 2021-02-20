import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/home/widgets/drawer/drawer_menu.dart';
import 'package:dolarbot_app/screens/home/widgets/floating_action_button/home_floating_action_button.dart';
import 'package:dolarbot_app/widgets/common/common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Widget bodyContent;
  final String title;
  final Function onAppBarRefresh;

  HomeScreen({
    Key key,
    @required this.bodyContent,
    this.title,
    @required this.onAppBarRefresh,
  })  : assert(bodyContent != null),
        super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: CommonAppBar(
        title: widget.title,
        showRefreshButton: true,
        onRefresh: widget.onAppBarRefresh,
      ),
      drawer: Drawer(
        child: DrawerMenu(),
      ),
      drawerEdgeDragWidth: 200,
      drawerEnableOpenDragGesture: true,
      body: widget.bodyContent,
      floatingActionButton: HomeFloatingActionButton(),
      floatingActionButtonLocation: HomeFloatingActionButton.getLocation(),
    );
  }
}
