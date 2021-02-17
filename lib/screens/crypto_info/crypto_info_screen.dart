import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate.dart';
import 'package:flutter/material.dart';

class CryptoInfoScreen extends StatefulWidget {
  final CryptoEndpoints cryptoEndpoint;

  const CryptoInfoScreen({
    Key key,
    @required this.cryptoEndpoint,
  }) : super(key: key);

  @override
  CryptoInfoScreenState createState() => CryptoInfoScreenState();
}

class CryptoInfoScreenState extends State<CryptoInfoScreen> {
  bool _forceRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: FutureScreenDelegate<CryptoResponse>(
          response: API.getCryptoRate(widget.cryptoEndpoint,
              forceRefresh: _forceRefresh),
          screen: (data) {
            return CurrencyInfoContainer(
              items: [
                CurrencyInfo(
                  title: "PESOS ARGENTINOS",
                  symbol: '\$',
                  value: data.arsPrice,
                ),
                CurrencyInfo(
                  title: "DÓLARES ESTADOUNIDENSES",
                  symbol: 'US\$',
                  value: data.usdPrice,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  refresh() async {
    setState(() {
      _forceRefresh = true;
    });
  }
}
