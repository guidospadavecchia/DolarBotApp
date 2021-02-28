import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

export 'package:dolarbot_app/models/settings.dart';
export 'package:dolarbot_app/util/util.dart';

abstract class IShareable<T extends ApiResponse> {
  String getShareInfo(T data);
}
