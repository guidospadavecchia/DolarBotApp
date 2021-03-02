import 'dart:typed_data';

import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:flutter/foundation.dart';

export 'package:dolarbot_app/api/responses/base/apiResponse.dart';

class ActiveScreenData extends ChangeNotifier {
  String _shareText;
  String _activeTitle;
  ApiResponse _activeData;
  Uint8List _imageCard;

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

  void setActiveCard(Uint8List imageCard, {bool updateListeners = true}) {
    _imageCard = imageCard;
    if (updateListeners) {
      notifyListeners();
    }
  }

  ApiResponse getActiveData() {
    return _activeData;
  }

  Uint8List getImageCard() {
    return _imageCard;
  }

  String getShareData() {
    return "${_activeTitle.toUpperCase()}\n\n$_shareText\n\nPowered by DolarBot";
  }

  String getActiveTitle() {
    return _activeTitle;
  }
}
