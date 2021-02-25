import 'package:dolarbot_app/api/responses/metalResponse.dart';
import 'package:dolarbot_app/interfaces/share_info.dart';
import 'package:dolarbot_app/screens/base/base_info_screen.dart';

class MetalInfoScreen extends BaseInfoScreen {
  final String title;
  final String headerTitle;
  final String headerIconAsset;
  final List<Color> gradiantColors;
  final MetalEndpoints metalEndpoint;

  MetalInfoScreen({
    this.title,
    @required this.metalEndpoint,
    this.headerTitle,
    this.headerIconAsset,
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
          return CurrencyInfoContainer(
            items: [
              CurrencyInfo(
                title: '/ ${data.unit}',
                symbol: data.currency == 'USD' ? 'US\$' : '\$',
                value: data.value,
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  String getShareInfo(MetalResponse data) {
    Settings settings = Provider.of<Settings>(context, listen: false);
    final currencyFormat = settings.getCurrencyFormat();
    final numberFormat = new NumberFormat("#,###,###.00", currencyFormat);
    String shareText = '';

    if (data != null) {
      final value = Util.isNumeric(data.value)
          ? numberFormat.format(double.parse(data.value))
          : 'N/A';
      final symbol = data.currency == 'USD' ? 'US\$' : '\$';
      DateTime date = DateTime.parse(data.timestamp.replaceAll('/', '-'));
      String formattedTime = DateFormat(Util.isSameDay(DateTime.now(), date)
              ? 'HH:mm'
              : 'HH:mm - dd-MM-yyyy')
          .format(date);

      shareText = '$symbol $value / ${data.unit}\nHora: $formattedTime';
    }

    return shareText;
  }
}
