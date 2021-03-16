import 'package:dolarbot_app/api/responses/metal_response.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
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

class _MetalInfoScreenState extends BaseInfoScreenState<MetalInfoScreen> with BaseScreen {
  bool isDataLoaded = false;
  MetalResponse data;

  @override
  void initState() {
    super.initState();
    if (!isDataLoaded) {
      loadData();
    }
  }

  @override
  Widget body() {
    if (!isDataLoaded) {
      return LoadingFuture();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      child: Column(
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
      ),
    );
  }

  @override
  Widget card() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    return BuildCard(data).fromCardData(context, widget.cardData, settings);
  }

  @override
  Future loadData() async {
    MetalEndpoints metalEndpoint =
        MetalEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);
    API.getMetalRate(metalEndpoint, forceRefresh: shouldForceRefresh).then(
      (value) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => setState(() {
            data = value;
            isDataLoaded = true;
            showSimpleFabMenu();
          }),
        );
      },
    );
  }

  @override
  String getShareText() {
    Settings settings = Provider.of<Settings>(context, listen: false);
    intl.NumberFormat numberFormat = settings.getNumberFormat().item1;

    String shareText = '';

    if (data != null) {
      final value = data.value.isNumeric() ? numberFormat.format(double.parse(data.value)) : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime =
          intl.DateFormat(DateTime.now().isSameDayAs(date) ? 'HH:mm' : 'HH:mm - dd-MM-yyyy')
              .format(date);

      shareText = '$symbol $value / ${data.unit}\nHora: $formattedTime';
    }

    return shareText;
  }

  @override
  FabOptionCalculatorDialog getCalculatorWidget() {
    String _currencyFormat = Provider.of<Settings>(context, listen: false).getCurrencyFormat();
    String decimalSeparator = _currencyFormat == "es_AR" ? "," : ".";
    String thousandSeparator = _currencyFormat == "es_AR" ? "." : ",";
    return FabOptionCalculatorDialog(
      calculator: MetalCalculator(
        usdValue: double.tryParse(data?.value),
        unit: data?.unit,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
      calculatorReversed: MetalCalculatorReversed(
        usdValue: double.tryParse(data?.value),
        unit: data?.unit,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
    );
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
