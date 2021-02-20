import 'package:flutter/foundation.dart';

class ActiveScreenData extends ChangeNotifier {
  String _shareData;
  String _activeTitle;

  void setShareData(String shareData) {
    _shareData = shareData;
    notifyListeners();
  }

  void setActiveTitle(String title) {
    _activeTitle = title;
    notifyListeners();
  }

  String getShareData() {
    return "${_activeTitle.toUpperCase()}\n\n$_shareData\n\nPowered by DolarBot";
  }

  String getActiveTitle() {
    return _activeTitle;
  }
}
