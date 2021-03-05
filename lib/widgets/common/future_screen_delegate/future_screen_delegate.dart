import 'package:dolarbot_app/widgets/common/future_screen_delegate/error_future.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
import 'package:dolarbot_app/classes/globals.dart';
import 'package:flutter/material.dart';

export 'package:loading_indicator/loading_indicator.dart';

typedef ScreenDataBuildFunction<T> = Widget Function(T data);

class FutureScreenDelegate<T> extends StatelessWidget {
  final Future<T> response;
  final ScreenDataBuildFunction<T> screen;
  final LoadingFuture loading;

  FutureScreenDelegate({
    @required this.response,
    @required this.screen,
    this.loading,
  }) : assert(response != null && screen != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: response,
      builder: (context, snapshot) {
        Globals.dataIsLoading = true;
        if (snapshot.connectionState != ConnectionState.done) {
          return loading != null ? loading : LoadingFuture();
        }

        if (snapshot.hasError) {
          return ErrorFuture();
        }

        Globals.dataIsLoading = false;
        return screen(snapshot.data);
      },
    );
  }
}
