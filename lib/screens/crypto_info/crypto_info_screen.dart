import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';
import 'package:dolarbot_app/widgets/cards/factory/factory_card.dart';
import 'package:dolarbot_app/widgets/cards/templates/base/base_card.dart';
import 'package:dolarbot_app/widgets/common/future_screen_delegate/loading_future.dart';
import 'package:intl/intl.dart';

class CryptoInfoScreen extends BaseInfoScreen {
  final String title;
  final CardData cardData;

  CryptoInfoScreen({
    @required this.title,
    @required this.cardData,
  }) : super(cardData: cardData, title: title);

  @override
  _CryptoInfoScreenState createState() => _CryptoInfoScreenState();
}

class _CryptoInfoScreenState extends BaseInfoScreenState<CryptoInfoScreen> with BaseScreen {
  bool isDataLoaded = false;
  CryptoResponse data;

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
    CryptoEndpoints cryptoEndpoint =
        CryptoEndpoints.values.firstWhere((e) => e.value == widget.cardData.endpoint);

    API.getCryptoRate(cryptoEndpoint, forceRefresh: shouldForceRefresh).then(
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
    NumberFormat numberFormat = settings.getNumberFormat().item1;

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
  FabOptionCalculatorDialog getCalculatorWidget() {
    String _currencyFormat = Provider.of<Settings>(context, listen: false).getCurrencyFormat();
    String decimalSeparator = _currencyFormat == "es_AR" ? "," : ".";
    String thousandSeparator = _currencyFormat == "es_AR" ? "." : ",";
    return FabOptionCalculatorDialog(
      calculator: CryptoCalculator(
        arsValue: double.tryParse(data?.arsPrice),
        arsValueWithTaxes: double.tryParse(data?.arsPriceWithTaxes),
        usdValue: double.tryParse(data?.usdPrice),
        cryptoCode: data.code,
        decimalSeparator: decimalSeparator,
        thousandSeparator: thousandSeparator,
      ),
      calculatorReversed: CryptoCalculatorReversed(
        usdValue: double.tryParse(data?.usdPrice ?? ''),
        cryptoCode: data.code,
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
        cardTag: widget.title,
        cardColors: widget.cardData.colors.map((color) => color.value).toList(),
        cardIconData: widget.cardData.iconData?.codePoint,
        cardIconAsset: widget.cardData.iconAsset);
  }

  @override
  Type getResponseType() => CryptoResponse;
}
