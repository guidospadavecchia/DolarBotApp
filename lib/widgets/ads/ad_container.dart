import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';

import '../../classes/ad_state.dart';
import '../../classes/theme_manager.dart';
import '../../screens/base/base_info_screen.dart';

class AdContainer extends StatefulWidget {
  const AdContainer({
    Key? key,
  }) : super(key: key);

  @override
  _AdContainerState createState() => _AdContainerState();
}

class _AdContainerState extends State<AdContainer> {
  BannerAd? banner;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then(
      (status) => setState(
        () {
          banner = BannerAd(
            size: BannerSize.BANNER,
            error: _AdError(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager.getGlobalBackgroundColor(context),
        border: Border(
          top: BorderSide(
            color: ThemeManager.getAdBorderColor(context),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: ThemeManager.getAdBorderColor(context),
            offset: Offset(0.0, 1.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      height: BannerSize.BANNER.size.height,
      child: Center(
        child: Container(
          color: Colors.transparent,
          child: banner != null ? banner! : SizedBox.shrink(),
          width: BannerSize.BANNER.size.width,
          height: BannerSize.BANNER.size.height,
        ),
      ),
    );
  }
}

class _AdError extends StatelessWidget {
  const _AdError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      alignment: Alignment.center,
      child: Icon(
        FontAwesomeIcons.solidFrown,
        size: 36,
        color: ThemeManager.getAdErrorIconColor(context),
      ),
    );
  }
}
