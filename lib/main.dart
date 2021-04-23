import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/hive/adapters/cache_entry_adapter.dart';
import 'package:dolarbot_app/classes/hive/adapters/favorite_rate_adapter.dart';
import 'package:dolarbot_app/classes/hive/adapters/historical_rate_adapter.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/settings.dart';
import 'package:dolarbot_app/screens/about/about_screen.dart';
import 'package:dolarbot_app/screens/options/options_screen.dart';
import 'package:dolarbot_app/screens/splash/splash_screen.dart';
import 'package:dolarbot_app/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  if (!kDebugMode) {
    await _preloadImages();
  }
  await GlobalConfiguration().loadFromAsset("app_settings");
  initializeHive();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(DolarBotApp(savedThemeMode: savedThemeMode));
  });
}

void _preloadImages() async {
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
  final AdaptiveThemeMode savedThemeMode;

  const DolarBotApp({Key key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeManager.getLightThemeData(),
      dark: ThemeManager.getDarkThemeData(),
      initial: savedThemeMode ?? ThemeManager.getDefaultTheme(context),
      builder: (lightTheme, darkTheme) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Settings()),
        ],
        child: OKToast(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DolarBot',
            theme: lightTheme,
            darkTheme: darkTheme,
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child,
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
                  break;
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
