import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

typedef ScreenDataBuildFunction<T> = Widget Function(T data);

class FutureScreenDelegate<T> extends StatefulWidget {
  final Future<T> response;
  final ScreenDataBuildFunction<T> screen;

  FutureScreenDelegate({
    @required this.response,
    @required this.screen,
  }) : assert(response != null && screen != null);

  @override
  State<StatefulWidget> createState() {
    return FutureScreenDelegateState(
      response: response,
      screen: screen,
    );
  }
}

class FutureScreenDelegateState<T> extends State<FutureScreenDelegate<T>> {
  Future<T> response;
  ScreenDataBuildFunction<T> screen;

  FutureScreenDelegateState({
    @required this.response,
    @required this.screen,
  }) : assert(screen != null);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: response,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return screen(snapshot.data);
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

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
      },
    );
  }
}
