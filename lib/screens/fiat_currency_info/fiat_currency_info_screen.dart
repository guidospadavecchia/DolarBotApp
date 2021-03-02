import 'package:dolarbot_app/api/responses/base/genericCurrencyResponse.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:intl/intl.dart';

class FiatCurrencyInfoScreen<T extends GenericCurrencyResponse>
    extends BaseInfoScreen {
  final String title;
  final String bannerTitle;
  final String bannerIconAsset;
  final IconData bannerIconData;
  final List<Color> gradiantColors;
  final DollarEndpoints dollarEndpoint;
  final EuroEndpoints euroEndpoint;
  final RealEndpoints realEndpoint;

  FiatCurrencyInfoScreen(
      {Key key,
      this.title,
      this.bannerTitle,
      this.bannerIconAsset,
      this.bannerIconData,
      this.gradiantColors,
      this.dollarEndpoint,
      this.euroEndpoint,
      this.realEndpoint})
      : assert((dollarEndpoint != null &&
                euroEndpoint == null &&
                realEndpoint == null) ||
            (euroEndpoint != null &&
                dollarEndpoint == null &&
                realEndpoint == null) ||
            (realEndpoint != null &&
                dollarEndpoint == null &&
                euroEndpoint == null)),
        super(
          title: title,
          bannerTitle: bannerTitle,
          bannerIconAsset: bannerIconAsset,
          bannerIconData: bannerIconData,
        );

  @override
  _FiatCurrencyInfoScreenState<T> createState() =>
      _FiatCurrencyInfoScreenState<T>(
          dollarEndpoint, euroEndpoint, realEndpoint);
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
      child: FutureScreenDelegate<T>(
        response: _getResponse<T>(),
        screen: (data) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => setActiveData(data, getShareInfo(data)));

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

      if (data != null && data is GenericCurrencyResponse) {
        return CardFavorite(
          showPoweredBy: true,
          header: CardHeader(
            title: widget.bannerTitle,
            showButtons: false,
          ),
          spaceBetweenItems: Spacing.medium,
          spaceBetweenHeader: Spacing.small,
          rates: [
            CardValue(
              title: "Compra",
              value: data.buyPrice,
              symbol: "\$",
              titleSize: data.sellPriceWithTaxes == null ? 16 : 14,
              valueSize: data.sellPriceWithTaxes == null ? 24 : 18,
            ),
            CardValue(
              title: "Venta",
              value: data.sellPrice,
              symbol: "\$",
              titleSize: data.sellPriceWithTaxes == null ? 16 : 14,
              valueSize: data.sellPriceWithTaxes == null ? 24 : 18,
            ),
            if (data.sellPriceWithTaxes != null)
              CardValue(
                title: "Ahorro",
                value: data.sellPriceWithTaxes,
                symbol: "\$",
              ),
          ],
          logo: CardLogo(
            iconAsset: widget.bannerIconAsset,
            iconData: widget.bannerIconData,
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
  String getShareInfo(T data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';
    if (data != null) {
      final buyPrice = Util.isNumeric(data.buyPrice)
          ? numberFormat.format(double.parse(data.buyPrice))
          : 'N/A';
      final sellPrice = Util.isNumeric(data.sellPrice)
          ? numberFormat.format(double.parse(data.sellPrice))
          : 'N/A';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      if (data.sellPriceWithTaxes != null) {
        final sellPriceWithTaxes = Util.isNumeric(data.sellPriceWithTaxes)
            ? numberFormat.format(double.parse(data.sellPriceWithTaxes))
            : 'N/A';
        shareText =
            'Compra:\t\$ $buyPrice\nVenta:\t\$ $sellPrice\nVenta Ahorro:\t\$ $sellPriceWithTaxes\nHora:\t$formattedTime';
      } else {
        shareText =
            'Compra:\t\$ $buyPrice\nVenta:\t\$ $sellPrice\nHora:\t$formattedTime';
      }
    }

    return shareText;
  }

  _getResponse<T extends GenericCurrencyResponse>() {
    if (dollarEndpoint != null) {
      return API.getDollarRate(dollarEndpoint,
          forceRefresh: shouldForceRefresh);
    } else if (euroEndpoint != null) {
      return API.getEuroRate(euroEndpoint, forceRefresh: shouldForceRefresh);
    } else if (realEndpoint != null) {
      return API.getRealRate(realEndpoint, forceRefresh: shouldForceRefresh);
    }
  }
}
