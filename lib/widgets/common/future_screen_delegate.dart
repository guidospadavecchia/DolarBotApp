import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

typedef ScreenDataBuildFunction<T> = Widget Function(T data);

class FutureScreenDelegate<T> extends StatelessWidget {
  final Future<T> response;
  final ScreenDataBuildFunction<T> screen;

  FutureScreenDelegate({
    @required this.response,
    @required this.screen,
  }) : assert(response != null && screen != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Padding(
            child: Center(
              child: SizedBox(
                width: 64,
                height: 64,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballScale,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            padding: EdgeInsets.only(top: 30, bottom: 10),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return screen(snapshot.data);
      },
    );
  }
}
