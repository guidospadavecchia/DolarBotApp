import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/classes/globals.dart';
import 'package:dolarbot_app/screens/home/widgets/fab_menu/fab_menu_option.dart';
import 'package:dolarbot_app/screens/home/widgets/fab_menu/share/fab_option_share.dart';
import 'package:dolarbot_app/widgets/toasts/toast_ok.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class FabMenu extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey;
  const FabMenu({
    Key key,
    this.fabKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveScreenData>(builder: (context, activeData, child) {
      if (!Globals.dataIsLoading) {
        return Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: FabCircularMenu(
            key: fabKey,
            alignment: Alignment.bottomRight,
            fabColor: ThemeManager.getGlobalAccentColor(context),
            fabOpenIcon: Icon(Icons.more_horiz,
                color: ThemeManager.getGlobalBackgroundColor(context)),
            fabCloseIcon: Icon(Icons.close,
                color: ThemeManager.getGlobalBackgroundColor(context)),
            fabMargin: EdgeInsets.only(bottom: 20, right: 20),
            fabSize: 64,
            ringColor: Colors.transparent,
            ringDiameter: MediaQuery.of(context).size.width * 0.6,
            fabElevation: 10,
            animationDuration: Duration(milliseconds: 600),
            animationCurve: Curves.easeInOutCirc,
            children: [
              FabOptionShare(
                activeData: activeData,
              ),
              // FabMenuOption(
              //   icon: Icons.share,
              //   onTap: () => share(
              //     activeData.getShareData(),
              //     title: activeData.getActiveTitle(),
              //   ),
              // ),
              FabMenuOption(
                icon: Icons.copy,
                onTap: () async => await copyToClipboard(
                  context,
                  activeData.getShareData(),
                ),
              ),
              FabMenuOption(
                icon: FontAwesomeIcons.calculator,
                onTap: () {
                  //TODO Implementar calculadora de valores
                  closeDrawer();
                },
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  void share(String text, {String title}) {
    Share.share(text, subject: title != null ? 'Cotización $title' : '');
    closeDrawer();
  }

  Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(
      new ClipboardData(
        text: text,
      ),
    )
        .then(
          (_) => closeDrawer(),
        )
        .then(
          (_) async => {
            Future.delayed(
              Duration(milliseconds: 100),
              () => showToastWidget(
                ToastOk(),
              ),
            ),
          },
        );
  }

  void closeDrawer() {
    if (fabKey.currentState.isOpen) {
      fabKey.currentState.close();
    }
  }
}
