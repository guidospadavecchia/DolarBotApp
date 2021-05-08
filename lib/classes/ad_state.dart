import 'package:flutter/foundation.dart' as Foundation;
import 'package:native_admob_flutter/native_admob_flutter.dart';

class AdState {
  static const String _kbannerAdUnitId = 'ca-app-pub-6542333312397599/3833588942';

  late final Future<void> initialization;
  static String get _bannerAdUnitId =>
      Foundation.kReleaseMode ? _kbannerAdUnitId : MobileAds.bannerAdTestUnitId;

  AdState() {
    initialization = MobileAds.initialize(bannerAdUnitId: AdState._bannerAdUnitId);
  }
}
