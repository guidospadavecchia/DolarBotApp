import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStatus {
  static Future<bool> isConnected() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();

    return result.any((element) => element != ConnectivityResult.none);
  }
}
