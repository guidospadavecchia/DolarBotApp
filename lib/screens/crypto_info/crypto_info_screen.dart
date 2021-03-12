import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/crypto_card.dart';
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
            endpoint: cryptoEndpoint.value);

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
  String getEndpointIdentifier() => cryptoEndpoint.toString();

  @override
  Widget body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: FutureScreenDelegate(
        response: API.getCryptoRate(
          cryptoEndpoint,
          forceRefresh: shouldForceRefresh,
        ),
        onLoading: onLoading,
        onFailedLoad: onErrorLoad,
        onSuccessfulLoad: onSuccessfulLoad,
        screen: (data) {
          WidgetsBinding.instance.addPostFrameCallback((_) =>
              setActiveData(data, "${widget.bannerTitle}", getShareInfo(data)));

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
        return CryptoCard(
          title: widget.bannerTitle,
          data: data,
          tag: widget.title,
          iconAsset: widget.bannerIconAsset,
          iconData: widget.bannerIconData,
          gradiantColors: widget.gradiantColors,
          showButtons: false,
          showPoweredBy: true,
          endpoint: widget.endpoint,
        );
      } else {
        return SizedBox.shrink();
      }
    });
  }

  @override
  String getShareInfo(CryptoResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final numberFormat = new NumberFormat(
      settings.getCurrencyPattern(),
      settings.getCurrencyFormat(),
    );
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

  @override
  FavoriteRate createFavorite() {
    return FavoriteRate(
        endpoint: cryptoEndpoint.value,
        cardResponseType: getResponseType().toString(),
        cardTitle: widget.bannerTitle,
        cardSubtitle: null,
        cardSymbol: null,
        cardTag: widget.title,
        cardColors: widget.gradiantColors.map((color) => color.value).toList(),
        cardIconData: widget.bannerIconData?.codePoint,
        cardIconAsset: widget.bannerIconAsset);
  }

  @override
  Type getResponseType() => CryptoResponse;
}
