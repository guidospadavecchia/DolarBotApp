import 'dart:convert';
import 'dart:developer';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'classes/app_config.dart';
import 'classes/hive/adapters/cache_entry_adapter.dart';
import 'classes/hive/adapters/favorite_rate_adapter.dart';
import 'classes/hive/adapters/historical_rate_adapter.dart';
import 'classes/settings.dart';
import 'classes/size_config.dart';
import 'classes/theme_manager.dart';
import 'screens/about/about_screen.dart';
import 'screens/options/options_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'util/util.dart';

export 'package:dolarbot_app/classes/app_config.dart';

void mainCommon(AppFlavor appFlavor) async {
  log("Starting as ${appFlavor.toString().split('.').last} version");

  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  if (!kDebugMode) {
    await _preloadImages();
  }
  await GlobalConfiguration().loadFromAsset("app_settings");
  initializeHive();

  AppConfig appConfig = await AppConfig.initialize(
      flavor: appFlavor,
      child: DolarBotApp(
        themeMode: savedThemeMode,
      ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(appConfig),
  );
}

Future _preloadImages() async {
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  final imagePaths = manifestMap.keys.where((String key) => key.contains('images/')).toList();

  List<AssetImage> providers = [];
  for (var i = 0; i < imagePaths.length; i++) {
    providers.add(AssetImage(imagePaths[i]));
  }

  await Util.loadImage(providers);
}

class DolarBotApp extends StatelessWidget {
  final AdaptiveThemeMode? themeMode;

  const DolarBotApp({
    Key? key,
    this.themeMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeManager.getLightThemeData(),
      dark: ThemeManager.getDarkThemeData(),
      initial: themeMode ?? ThemeManager.getDefaultTheme(context),
      builder: (lightTheme, darkTheme) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Settings()),
        ],
        child: OKToast(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConfig.of(context).appName,
            theme: lightTheme,
            darkTheme: darkTheme,
            builder: (BuildContext context, Widget? child) {
              SizeConfig().init(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
                child: child!,
              );
            },
            home: SplashScreen(),
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case AboutScreen.routeName:
                  return PageTransition(
                    child: AboutScreen(),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                  );
                case OptionsScreen.routeName:
                  return PageTransition(
                    child: OptionsScreen(),
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                  );
                default:
                  return null;
              }
            },
          ),
        ),
      ),
    );
  }
}

void initializeHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CacheEntryAdapter());
  Hive.registerAdapter(FavoriteRateAdapter());
  Hive.registerAdapter(HistoricalRateAdapter());

  await Future.wait([
    Hive.openBox('cache'),
    Hive.openBox('favorites'),
    Hive.openBox('settings'),
    Hive.openBox('historicalRates'),
  ]);
}
