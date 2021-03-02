import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_favorite.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/card_value.dart';
import 'package:intl/intl.dart' as intl;

class MetalInfoScreen extends BaseInfoScreen {
  final String title;
  final String bannerTitle;
  final String bannerIconAsset;
  final List<Color> gradiantColors;
  final MetalEndpoints metalEndpoint;

  MetalInfoScreen({
    this.title,
    @required this.metalEndpoint,
    this.bannerTitle,
    this.bannerIconAsset,
    this.gradiantColors,
  }) : super(title: title);

  @override
  _MetalInfoScreenState createState() => _MetalInfoScreenState(metalEndpoint);
}

class _MetalInfoScreenState extends BaseInfoScreenState<MetalInfoScreen>
    with BaseScreen
    implements IShareable<MetalResponse> {
  final MetalEndpoints metalEndpoint;

  _MetalInfoScreenState(this.metalEndpoint);

  @override
  Widget body() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: FutureScreenDelegate<MetalResponse>(
        response:
            API.getMetalRate(metalEndpoint, forceRefresh: shouldForceRefresh),
        screen: (data) {
          WidgetsBinding.instance.addPostFrameCallback(
              (_) => setActiveData(data, getShareInfo(data)));

          return Column(
            children: [
              banner(),
              CurrencyInfoContainer(
                items: [
                  CurrencyInfo(
                    title: '/ ${data.unit}',
                    symbol: data.currency == 'USD' ? 'US\$' : '\$',
                    value: data.value,
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
    return Consumer<ActiveScreenData>(
      builder: (context, activeData, child) {
        ApiResponse data = activeData.getActiveData();

        if (data != null && data is MetalResponse) {
          return CardFavorite(
            showPoweredBy: true,
            height: 110,
            header: CardHeader(
              title: widget.bannerTitle,
              showButtons: false,
            ),
            spaceBetweenHeader: Spacing.small,
            rates: [
              CardValue(
                title: "/ Onza",
                value: data.value,
                symbol: data.currency == 'USD' ? 'US\$' : '\$',
                direction: Axis.horizontal,
                textDirection: TextDirection.rtl,
                spaceBetweenTitle: Spacing.small,
                crossAlignment: WrapCrossAlignment.center,
                valueSize: 32,
              ),
            ],
            logo: CardLogo(
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
      },
    );
  }

  @override
  String getShareInfo(MetalResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new intl.NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';

    if (data != null) {
      final value = Util.isNumeric(data.value)
          ? numberFormat.format(double.parse(data.value))
          : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = intl.DateFormat(
              Util.isSameDay(DateTime.now(), date)
                  ? 'HH:mm'
                  : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText = '$symbol $value / ${data.unit}\nHora: $formattedTime';
    }

    return shareText;
  }
}
