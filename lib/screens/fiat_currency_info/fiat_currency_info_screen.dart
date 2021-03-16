import 'package:dolarbot_app/api/responses/base/generic_currency_response.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:intl/intl.dart';

class FiatCurrencyInfoScreen<T extends GenericCurrencyResponse> extends BaseInfoScreen {
  final String title;
  final CardData cardData;
  final DollarEndpoints dollarEndpoint;
  final EuroEndpoints euroEndpoint;
  final RealEndpoints realEndpoint;

  FiatCurrencyInfoScreen(
      {Key key,
      this.title,
      this.cardData,
      this.dollarEndpoint,
      this.euroEndpoint,
      this.realEndpoint})
      : assert((dollarEndpoint != null && euroEndpoint == null && realEndpoint == null) ||
            (euroEndpoint != null && dollarEndpoint == null && realEndpoint == null) ||
            (realEndpoint != null && dollarEndpoint == null && euroEndpoint == null)),
        super(cardData: cardData, title: title);

  @override
  _FiatCurrencyInfoScreenState<T> createState() =>
      _FiatCurrencyInfoScreenState<T>(dollarEndpoint, euroEndpoint, realEndpoint);
}

class _FiatCurrencyInfoScreenState<T extends GenericCurrencyResponse>
    extends BaseInfoScreenState<FiatCurrencyInfoScreen<T>>
    with BaseScreen
    implements IShareable<T> {
  final DollarEndpoints dollarEndpoint;
  final EuroEndpoints euroEndpoint;
  final RealEndpoints realEndpoint;

  _FiatCurrencyInfoScreenState(
    this.dollarEndpoint,
    this.euroEndpoint,
    this.realEndpoint,
  );

  @override
  Color setColorAppbar() => ThemeManager.getForegroundColor();

  @override
  Widget body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: FutureScreenDelegate(
        response: _getResponse<T>(),
        onLoading: onLoading,
        onFailedLoad: onErrorLoad,
        onSuccessfulLoad: onSuccessfulLoad,
        screen: (data) {
          WidgetsBinding.instance.addPostFrameCallback((_) => setActiveData(
              data, "${widget.title} - ${widget.cardData.title}", getShareInfo(data)));

          return Column(
            children: [
              banner(),
              CurrencyInfoContainer(
                items: [
                  CurrencyInfo(
                    title: "COMPRA",
                    symbol: '\$',
                    value: data.buyPrice,
                  ),
                  CurrencyInfo(
                    title: "VENTA",
                    symbol: '\$',
                    value: data.sellPrice,
                  ),
                  if (data.sellPriceWithTaxes != null)
                    CurrencyInfo(
                      title: "VENTA + IMPUESTOS",
                      symbol: '\$',
                      value: data.sellPriceWithTaxes,
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
  String getShareInfo(T data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final numberFormat = new NumberFormat(
      settings.getCurrencyPattern(),
      settings.getCurrencyFormat(),
    );
    String shareText = '';
    if (data != null) {
      final buyPrice =
          data.buyPrice.isNumeric() ? numberFormat.format(double.parse(data.buyPrice)) : 'N/A';
      final sellPrice =
          data.sellPrice.isNumeric() ? numberFormat.format(double.parse(data.sellPrice)) : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);

      if (data.sellPriceWithTaxes != null) {
        final sellPriceWithTaxes = data.sellPriceWithTaxes.isNumeric()
            ? numberFormat.format(double.parse(data.sellPriceWithTaxes))
            : 'N/A';
        shareText =
            'Compra: \t\t\$ $buyPrice\nVenta: \t\t\$ $sellPrice\nVenta Ahorro: \t\$ $sellPriceWithTaxes\nHora: \t\t$formattedTime';
      } else {
        shareText = 'Compra: \t\t\$ $buyPrice\nVenta: \t\t\$ $sellPrice\nHora: \t\t$formattedTime';
      }
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

  Type getResponseType() {
    Type responseType;
    if (dollarEndpoint != null) responseType = DollarResponse;
    if (euroEndpoint != null) responseType = EuroResponse;
    if (realEndpoint != null) responseType = RealResponse;
    return responseType;
  }

  _getResponse<T extends GenericCurrencyResponse>() {
    if (dollarEndpoint != null) {
      return API.getDollarRate(dollarEndpoint, forceRefresh: shouldForceRefresh);
    } else if (euroEndpoint != null) {
      return API.getEuroRate(euroEndpoint, forceRefresh: shouldForceRefresh);
    } else if (realEndpoint != null) {
      return API.getRealRate(realEndpoint, forceRefresh: shouldForceRefresh);
    }
  }
}
