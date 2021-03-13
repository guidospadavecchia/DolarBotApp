import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:intl/intl.dart' as intl;

class MetalInfoScreen extends BaseInfoScreen {
  final String title;
  final CardData cardData;

  MetalInfoScreen({
    @required this.title,
    @required this.cardData,
  }) : super(cardData: cardData, title: title);

  @override
  _MetalInfoScreenState createState() => _MetalInfoScreenState();
}

class _MetalInfoScreenState extends BaseInfoScreenState<MetalInfoScreen>
    with BaseScreen
    implements IShareable<MetalResponse> {
  @override
  String getEndpointIdentifier() => widget.cardData.endpoint;

  @override
  Widget body() {
    MetalEndpoints metalEndpoint = MetalEndpoints.values
        .firstWhere((e) => e.value == widget.cardData.endpoint);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: FutureScreenDelegate(
        response: API.getMetalRate(
          metalEndpoint,
          forceRefresh: shouldForceRefresh,
        ),
        onLoading: onLoading,
        onFailedLoad: onErrorLoad,
        onSuccessfulLoad: onSuccessfulLoad,
        screen: (data) {
          WidgetsBinding.instance.addPostFrameCallback((_) => setActiveData(
              data,
              "${widget.title} - ${widget.cardData.title}",
              getShareInfo(data)));

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

        return BuildCard(data).fromCardData(context, widget.cardData);
      },
    );
  }

  @override
  String getShareInfo(MetalResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final numberFormat = new intl.NumberFormat(
      settings.getCurrencyPattern(),
      settings.getCurrencyFormat(),
    );
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
        endpoint: widget.cardData.endpoint,
        cardResponseType: widget.cardData.response.toString(),
        cardTitle: widget.cardData.title,
        cardSubtitle: null,
        cardSymbol: null,
        cardTag: widget.cardData.tag,
        cardColors: widget.cardData.colors.map((color) => color.value).toList(),
        cardIconData: widget.cardData.iconData?.codePoint,
        cardIconAsset: widget.cardData.iconAsset);
  }

  @override
  Type getResponseType() => MetalResponse;
}
