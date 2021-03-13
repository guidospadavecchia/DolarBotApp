import 'package:dolarbot_app/api/responses/base/api_response.dart';
import 'package:flutter/foundation.dart';

export 'package:dolarbot_app/api/responses/base/api_response.dart';

class ActiveScreenData extends ChangeNotifier {
  String _shareText;
  String _shareTitle;
  ApiResponse _activeData;

  void setActiveData(ApiResponse data, String shareTitle, String shareText,
      {bool updateListeners = true}) {
    _activeData = data;
    _shareTitle = shareTitle;
    _shareText = shareText;
    if (updateListeners) {
      notifyListeners();
    }
  }

  ApiResponse getActiveData() {
    return _activeData;
  }

  String getShareData() {
    return "${_shareTitle.toUpperCase()}\n\n$_shareText\n\nPowered by DolarBot";
  }
}
