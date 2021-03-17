import 'package:connectivity/connectivity.dart';

class ConnectivityStatus {
  static Future<bool> isConnected() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
