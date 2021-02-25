import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';

class CryptoInfoScreen extends BaseInfoScreen {
  final String title;
  final CryptoEndpoints cryptoEndpoint;

  CryptoInfoScreen({
    this.title,
    @required this.cryptoEndpoint,
  }) : super(title: title);

  @override
  _CryptoInfoScreenState createState() =>
      _CryptoInfoScreenState(cryptoEndpoint);
}

class _CryptoInfoScreenState extends BaseInfoScreenState<CryptoInfoScreen>
    with BaseScreen
    implements IShareable<CryptoResponse> {
  final CryptoEndpoints cryptoEndpoint;

  _CryptoInfoScreenState(this.cryptoEndpoint);

  @override
  Widget body() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 80),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: FutureScreenDelegate<CryptoResponse>(
          response: API.getCryptoRate(cryptoEndpoint,
              forceRefresh: shouldForceRefresh),
          screen: (data) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => setActiveData(
                data,
                getShareInfo(data),
              ),
            );
            return CurrencyInfoContainer(
              items: [
                CurrencyInfo(
                  title: "PESOS ARGENTINOS",
                  symbol: '\$',
                  value: data.arsPrice,
                ),
                CurrencyInfo(
                  title: "PESOS ARGENTINOS + IMPUESTOS",
                  symbol: '\$',
                  value: data.arsPriceWithTaxes,
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

  @override
  String getShareInfo(CryptoResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';

    if (data != null) {
      final arsPrice = Util.isNumeric(data.arsPrice)
          ? numberFormat.format(double.parse(data.arsPrice))
          : 'N/A';
      final arsPriceWithTaxes = Util.isNumeric(data.arsPrice)
          ? numberFormat.format(double.parse(data.arsPriceWithTaxes))
          : 'N/A';
      final usdPrice = Util.isNumeric(data.usdPrice)
          ? numberFormat.format(double.parse(data.usdPrice))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText =
          'Dólares:\tUS\$ $usdPrice\nPesos:\t\$ $arsPrice\nPesos + Imp%:\t\$ $arsPriceWithTaxes\nHora: $formattedTime';
    }

    return shareText;
  }
}
