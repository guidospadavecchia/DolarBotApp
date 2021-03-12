import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/error_future.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
import 'package:flutter/material.dart';

export 'package:loading_indicator/loading_indicator.dart';

typedef ScreenDataBuildFunction<T> = Widget Function(T data);

class FutureScreenDelegate extends StatelessWidget {
  final Future response;
  final ScreenDataBuildFunction screen;
  final LoadingFuture loadingWidget;
  final Function onLoading;
  final Function onSuccessfulLoad;
  final Function onFailedLoad;

  FutureScreenDelegate({
    @required this.response,
    @required this.screen,
    this.loadingWidget,
    this.onLoading,
    this.onSuccessfulLoad,
    this.onFailedLoad,
  }) : assert(response != null && screen != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          if (onLoading != null) {
            onLoading();
          }
          return loadingWidget != null ? loadingWidget : LoadingFuture();
        }

        Widget screenWidget;
        if (snapshot.hasError || snapshot.hasData) {
          if (snapshot.hasError) {
            screenWidget = ErrorFuture();
            if (onFailedLoad != null) {
              onFailedLoad();
            }
          } else {
            screenWidget = screen(snapshot.data);
            if (onSuccessfulLoad != null) {
              onSuccessfulLoad();
            }
          }
        }

        return screenWidget;
      },
    );
  }
}
