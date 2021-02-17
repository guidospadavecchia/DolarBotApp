import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingFuture extends StatelessWidget {
  const LoadingFuture({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
