import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate.dart';
import 'package:flutter/material.dart';

class MetalInfoScreen extends StatelessWidget {
  final MetalEndpoints metalEndpoint;

  const MetalInfoScreen({
    Key key,
    @required this.metalEndpoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: FutureScreenDelegate<MetalResponse>(
          response: API.getMetalRate(metalEndpoint),
          screen: (data) {
            return CurrencyInfo(
              title: '/ ${data.unit}',
              symbol: data.currency,
              value: data.value,
            );
          },
        ),
      ),
    );
  }
}
