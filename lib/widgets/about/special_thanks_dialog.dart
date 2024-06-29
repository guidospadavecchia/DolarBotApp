import 'package:flutter/material.dart';

import '../../classes/size_config.dart';
import '../../classes/theme_manager.dart';
import '../common/blur_dialog.dart';
import '../common/simple_button.dart';

class SpecialThanksDialog extends StatelessWidget {
  final List<String> names;

  const SpecialThanksDialog({
    Key? key,
    required this.names,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurDialog(
      dialog: Dialog(
        insetPadding: const EdgeInsets.all(25),
        child: Container(
          width: SizeConfig.screenWidth * 0.8,
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Alpha & Beta Testers",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                    color: ThemeManager.getPrimaryTextColor(context),
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
                indent: 15,
                endIndent: 15,
                height: 0,
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.blockSizeHorizontal * 5,
                ),
                constraints: BoxConstraints(
                  maxHeight: SizeConfig.screenHeight / 4,
                ),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overScroll) {
                    overScroll.disallowIndicator();
                    return false;
                  },
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeVertical,
                    ),
                    children: names
                        .map((x) => Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical / 2,
                              ),
                              child: Text(
                                x,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Center(
                child: SimpleButton(
                  text: 'Volver',
                  icon: Icons.arrow_back,
                  onPressed: () {
                    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
