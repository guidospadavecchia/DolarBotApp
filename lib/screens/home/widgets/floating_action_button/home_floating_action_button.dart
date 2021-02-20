import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/widgets/toasts/toast_ok.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class HomeFloatingActionButton extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey;
  const HomeFloatingActionButton({
    Key key,
    this.fabKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ActiveScreenData>(builder: (context, activeData, child) {
      return FabCircularMenu(
        key: fabKey,
        alignment: Alignment.bottomRight,
        fabColor: ThemeManager.getGlobalAccentColor(context),
        fabOpenIcon: Icon(Icons.more_horiz,
            color: ThemeManager.getGlobalBackgroundColor(context)),
        fabCloseIcon: Icon(Icons.close,
            color: ThemeManager.getGlobalBackgroundColor(context)),
        fabMargin: EdgeInsets.only(bottom: 25, right: 25),
        fabSize: 64,
        ringColor: Colors.transparent,
        ringDiameter: MediaQuery.of(context).size.width * 0.8,
        //ringWidth: 100,
        fabElevation: 10,
        animationDuration: Duration(milliseconds: 600),
        animationCurve: Curves.easeInOutCirc,
        children: [
          ClipOval(
            child: Material(
              color: Colors.green,
              child: InkWell(
                splashColor: Theme.of(context).accentColor,
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.share,
                        color: ThemeManager.getGlobalBackgroundColor(context))),
                onTap: () => share(
                  activeData.getShareData(),
                  title: activeData.getActiveTitle(),
                ),
              ),
            ),
          ),
          ClipOval(
            child: Material(
              color: Colors.green,
              child: InkWell(
                splashColor: Theme.of(context).accentColor,
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(Icons.copy,
                        color: ThemeManager.getGlobalBackgroundColor(context))),
                onTap: () async => await copyToClipboard(
                  context,
                  activeData.getShareData(),
                ),
              ),
            ),
          ),
          ClipOval(
            child: Material(
              color: Colors.green,
              child: InkWell(
                splashColor: Theme.of(context).accentColor,
                child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(FontAwesomeIcons.calculator,
                        color: ThemeManager.getGlobalBackgroundColor(context))),
                onTap: () {
                  //TODO Implementar calculadora de valores
                  closeDrawer();
                },
              ),
            ),
          ),
        ],
      );
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
