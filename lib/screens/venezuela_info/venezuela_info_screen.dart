import 'package:dolarbot_app/api/api.dart';
import 'package:dolarbot_app/api/responses/base/apiResponse.dart';
import 'package:dolarbot_app/widgets/common/currency_info_container.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate.dart';
import 'package:flutter/material.dart';

class VenezuelaInfoScreen extends StatefulWidget {
  final VenezuelaEndpoints vzlaEndpoint;

  const VenezuelaInfoScreen({
    Key key,
    @required this.vzlaEndpoint,
  }) : super(key: key);

  @override
  VenezuelaInfoScreenState createState() => VenezuelaInfoScreenState();
}

class VenezuelaInfoScreenState extends State<VenezuelaInfoScreen> {
  bool _forceRefresh = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: FutureScreenDelegate<VenezuelaResponse>(
          response:
              API.getVzlaRate(widget.vzlaEndpoint, forceRefresh: _forceRefresh),
          screen: (data) {
            return CurrencyInfoContainer(
              items: [
                CurrencyInfo(
                  title: 'PROMEDIO BANCOS',
                  symbol: 'Bs.',
                  value: data.bankPrice,
                ),
                CurrencyInfo(
                  title: "PARALELO",
                  symbol: 'Bs.',
                  value: data.blackMarketPrice,
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
