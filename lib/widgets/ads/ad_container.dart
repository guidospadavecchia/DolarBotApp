import 'dart:developer';
import 'package:dolarbot_app/classes/ad_state.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
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
    adState.initialization.then((status) => setState(() {
          banner = BannerAd(
            size: AdSize.banner,
            adUnitId: adState.bannerAdUnitId,
            request: AdRequest(),
            listener: AdListener(
              onAdLoaded: (ad) => log('[AddState] Ad loaded: ${ad.adUnitId}.'),
              onAdOpened: (ad) => log('[AddState] Ad opened: ${ad.adUnitId}.'),
              onAdClosed: (ad) => log('[AddState] Ad closed: ${ad.adUnitId}.'),
              onAdFailedToLoad: (ad, error) =>
                  log('[AddState] Ad failed to load: ${ad.adUnitId} ($error).'),
            ),
          )..load();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeManager.getGlobalBackgroundColor(context),
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0.0, 1.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      height: 55,
      child: Center(
        child: Container(
          color: Colors.transparent,
          child: banner != null ? AdWidget(ad: banner!) : SizedBox.shrink(),
          width: 320,
          height: 50,
        ),
      ),
    );
  }
}
