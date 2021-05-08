import 'package:flutter/foundation.dart' as Foundation;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdState {
  static const String _kbannerAdUnitId = 'ca-app-pub-6542333312397599/3833588942';
  static const String _kbannerTestAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

  Future<InitializationStatus> initialization;
  Function? onAdLoaded;
  Function? onAdFailedToLoad;
  String get bannerAdUnitId => Foundation.kReleaseMode ? _kbannerAdUnitId : _kbannerTestAdUnitId;

  AdState(
    this.initialization, {
    this.onAdLoaded,
    this.onAdFailedToLoad,
  });
}
