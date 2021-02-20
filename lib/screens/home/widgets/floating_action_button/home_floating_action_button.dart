import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveScreenData>(builder: (context, activeData, child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: EdgeInsets.only(right: 10),
          // decoration: BoxDecoration(
          //     border: Border.all(
          //       color: ThemeManager.getGlobalBackgroundColor(context),
          //       width: 5,
          //     ),
          //     shape: BoxShape.circle),
          child: FloatingActionButton(
            onPressed: () {
              print(activeData.getShareData());
            },
            backgroundColor: ThemeManager.getGlobalAccentColor(context),
            foregroundColor: ThemeManager.getGlobalBackgroundColor(context),
            tooltip: 'Opciones',
            elevation: 0,
            child: Icon(Icons.more_horiz),
          ),
        ),
      );
    });
  }

  static FloatingActionButtonLocation getLocation() {
    return FloatingActionButtonLocation.centerFloat;
  }
}
