import 'package:dolarbot_app/api/responses/base/apiResponse.dart';

abstract class IShareable<T extends ApiResponse> {
  void setShareInfo(T data);
}
