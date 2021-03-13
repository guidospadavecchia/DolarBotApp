import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:intl/intl.dart';

class CryptoInfoScreen extends BaseInfoScreen {
  final String title;
  final CardData cardData;

  CryptoInfoScreen({
    @required this.title,
    @required this.cardData,
  });

  @override
  _CryptoInfoScreenState createState() => _CryptoInfoScreenState();
}

class _CryptoInfoScreenState extends BaseInfoScreenState<CryptoInfoScreen>
    with BaseScreen
    implements IShareable<CryptoResponse> {
  @override
  Widget body() {
    CryptoEndpoints cryptoEndpoint =
        CryptoEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);

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
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => setActiveData(data, "${widget.cardData.title}", getShareInfo(data)));

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

      return BuildCard(data).fromCardData(context, widget.cardData);
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
      final arsPrice =
          data.arsPrice.isNumeric() ? numberFormat.format(double.parse(data.arsPrice)) : 'N/A';
      final arsPriceWithTaxes = data.arsPriceWithTaxes.isNumeric()
          ? numberFormat.format(double.parse(data.arsPriceWithTaxes))
          : 'N/A';
      final usdPrice =
          data.usdPrice.isNumeric() ? numberFormat.format(double.parse(data.usdPrice)) : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);

      shareText =
          'Dólares: \t\tUS\$ $usdPrice\nPesos: \t\t\$ $arsPrice\nPesos + Imp.: \t\$ $arsPriceWithTaxes\nHora: \t\t$formattedTime';
    }

    return shareText;
  }

  @override
  FavoriteRate createFavorite() {
    return FavoriteRate(
        endpoint: widget.cardData.endpoint,
        cardResponseType: widget.cardData.response.toString(),
        cardTitle: widget.cardData.title,
        cardSubtitle: null,
        cardSymbol: null,
        cardTag: widget.title,
        cardColors: widget.cardData.colors.map((color) => color.value).toList(),
        cardIconData: widget.cardData.iconData?.codePoint,
        cardIconAsset: widget.cardData.iconAsset);
  }

  @override
  Type getResponseType() => CryptoResponse;
}
