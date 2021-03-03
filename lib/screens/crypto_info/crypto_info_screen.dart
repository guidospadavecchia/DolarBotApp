import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:intl/intl.dart';

class CryptoInfoScreen extends BaseInfoScreen {
  final String title;
  final String bannerTitle;
  final IconData bannerIconData;
  final List<Color> gradiantColors;
  final CryptoEndpoints cryptoEndpoint;

  CryptoInfoScreen({
    this.title,
    this.bannerTitle,
    this.bannerIconData,
    this.gradiantColors,
    @required this.cryptoEndpoint,
  }) : super(
          title: title,
          bannerTitle: bannerTitle,
          bannerIconData: bannerIconData,
        );

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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: FutureScreenDelegate<CryptoResponse>(
        response:
            API.getCryptoRate(cryptoEndpoint, forceRefresh: shouldForceRefresh),
        screen: (data) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => setActiveData(data, getShareInfo(data)));

          return Column(
            children: [
              banner(),
              CurrencyInfoContainer(
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
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget card() {
    return Consumer<ActiveScreenData>(builder: (context, activeData, child) {
      ApiResponse data = activeData.getActiveData();

      if (data != null && data is CryptoResponse) {
        return CardFavorite(
          showPoweredBy: true,
          height: 290,
          header: CardHeader(
            title: widget.bannerTitle,
            showButtons: false,
          ),
          spaceBetweenItems: Spacing.large,
          direction: Axis.vertical,
          rates: [
            CardValue(
              title: "Pesos Argentinos",
              value: data.arsPrice,
              symbol: "\$",
              valueSize: 22,
            ),
            CardValue(
              title: "Pesos Argentinos + Impuestos",
              value: data.arsPriceWithTaxes,
              symbol: "\$",
              valueSize: 22,
            ),
            CardValue(
              title: "Dólares Estadounidenses",
              value: data.usdPrice,
              symbol: "US\$",
              valueSize: 22,
            ),
          ],
          logo: CardLogo(
            iconData: widget.bannerIconData,
            iconAsset: widget.bannerIconAsset,
            tag: widget.title,
          ),
          lastUpdated: CardLastUpdated(
            timestamp: data.timestamp,
          ),
          gradiantColors: widget.gradiantColors,
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }

  @override
  String getShareInfo(CryptoResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';

    if (data != null) {
      final arsPrice = data.arsPrice.isNumeric()
          ? numberFormat.format(double.parse(data.arsPrice))
          : 'N/A';
      final arsPriceWithTaxes = data.arsPriceWithTaxes.isNumeric()
          ? numberFormat.format(double.parse(data.arsPriceWithTaxes))
          : 'N/A';
      final usdPrice = data.usdPrice.isNumeric()
          ? numberFormat.format(double.parse(data.usdPrice))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(
              DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText =
          'Dólares: \t\tUS\$ $usdPrice\nPesos: \t\t\$ $arsPrice\nPesos + Imp.: \t\$ $arsPriceWithTaxes\nHora: \t\t$formattedTime';
    }

    return shareText;
  }
}
