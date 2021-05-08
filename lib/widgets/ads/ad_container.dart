import 'package:dolarbot_app/classes/ad_state.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:native_admob_flutter/native_admob_flutter.dart';
import 'package:provider/provider.dart';

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
            loading: _AdLoading(),
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
      height: BannerSize.BANNER.size.height + 10,
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
    );
  }
}

class _AdLoading extends StatelessWidget {
  const _AdLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingIndicator(
        color: ThemeManager.getLoadingIndicatorColor(context),
        indicatorType: Indicator.ballPulse,
      ),
    );
  }
}
