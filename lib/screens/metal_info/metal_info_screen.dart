import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/screens/home/widgets/cards/templates/metal_card.dart';
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
  }) : super(
          title: title,
          endpoint: metalEndpoint.value,
        );

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
          return MetalCard(
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
      final value = data.value.isNumeric()
          ? numberFormat.format(double.parse(data.value))
          : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = intl.DateFormat(
              DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText = '$symbol $value / ${data.unit}\nHora: $formattedTime';
    }

    return shareText;
  }

  @override
  FavoriteRate createFavorite() {
    return FavoriteRate(
        endpoint: metalEndpoint.value,
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
  Type getResponseType() => MetalResponse;
}
