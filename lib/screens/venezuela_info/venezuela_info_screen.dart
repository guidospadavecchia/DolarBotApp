import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:intl/intl.dart';

class VenezuelaInfoScreen extends BaseInfoScreen {
  final String title;
  final String bannerTitle;
  final IconData bannerIconData;
  final List<Color> gradiantColors;
  final VenezuelaEndpoints venezuelaEndpoint;

  VenezuelaInfoScreen({
    this.title,
    @required this.bannerTitle,
    @required this.bannerIconData,
    this.gradiantColors,
    @required this.venezuelaEndpoint,
  }) : super(
            title: title,
            bannerTitle: bannerTitle,
            bannerIconData: bannerIconData);

  @override
  _VenezuelaInfoScreenState createState() =>
      _VenezuelaInfoScreenState(venezuelaEndpoint);
}

class _VenezuelaInfoScreenState extends BaseInfoScreenState<VenezuelaInfoScreen>
    with BaseScreen
    implements IShareable<VenezuelaResponse> {
  final VenezuelaEndpoints venezuelaEndpoint;

  _VenezuelaInfoScreenState(this.venezuelaEndpoint);

  @override
  Widget body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: FutureScreenDelegate<VenezuelaResponse>(
        response: API.getVzlaRate(venezuelaEndpoint,
            forceRefresh: shouldForceRefresh),
        screen: (data) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => setActiveData(data, getShareInfo(data)));
          return Column(
            children: [
              banner(),
              CurrencyInfoContainer(
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
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  String getShareInfo(VenezuelaResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';

    if (data != null) {
      final blackMarketValue = Util.isNumeric(data.blackMarketPrice)
          ? numberFormat.format(double.parse(data.blackMarketPrice))
          : 'N/A';
      final banksValue = Util.isNumeric(data.bankPrice)
          ? numberFormat.format(double.parse(data.bankPrice))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText =
          'Bancos:\tBs. $banksValue\nParalelo:\tBs. $blackMarketValue\nHora:\t$formattedTime';
    }

    return shareText;
  }
}
