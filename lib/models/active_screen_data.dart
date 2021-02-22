import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:flutter/foundation.dart';

export 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class ActiveScreenData extends ChangeNotifier {
  String _shareText;
  String _activeTitle;
  ApiResponse _activeData;

  void setActiveData(ApiResponse data, String shareText,
      {bool updateListeners = true}) {
    _activeData = data;
    _shareText = shareText;
    if (updateListeners) {
      notifyListeners();
    }
  }

  void setActiveTitle(String title, {bool updateListeners = true}) {
    _activeTitle = title;
    if (updateListeners) {
      notifyListeners();
    }
  }

  ApiResponse getActiveData() {
    return _activeData;
  }

  String getShareData() {
    return "${_activeTitle.toUpperCase()}\n\n$_shareText\n\nPowered by DolarBot";
  }

  String getActiveTitle() {
    return _activeTitle;
  }
}
