import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/hive/adapters/cache_entry_adapter.dart';
import 'package:dolarbot_app/classes/hive/adapters/favorite_rate_adapter.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/models/active_screen_data.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  await _preloadImages();
  await GlobalConfiguration().loadFromAsset("app_settings");
  initializeHive();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(DolarBotApp(savedThemeMode: savedThemeMode));
  });
}

void _preloadImages() async {
  final manifestContent = await rootBundle.loadString('AssetManifest.json');
  final Map<String, dynamic> manifestMap = json.decode(manifestContent);
  final imagePaths =
      manifestMap.keys.where((String key) => key.contains('images/')).toList();

  List<AssetImage> providers = List<AssetImage>();
  for (var i = 0; i < imagePaths.length; i++) {
    providers.add(AssetImage(imagePaths[i]));
  }

  //TODO: Enviar lista de imágenes.
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
          ChangeNotifierProvider(create: (context) => ActiveScreenData()),
        ],
        child: OKToast(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'DolarBot',
            theme: lightTheme,
            darkTheme: darkTheme,
            home: SplashScreen(),
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case AboutScreen.routeName:
                  return PageTransition(
                    child: AboutScreen(),
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 100),
                    reverseDuration: Duration(milliseconds: 100),
                  );
                case OptionsScreen.routeName:
                  return PageTransition(
                    child: OptionsScreen(
                      title: "Opciones",
                    ),
                    type: PageTransitionType.rightToLeft,
                    duration: Duration(milliseconds: 100),
                    reverseDuration: Duration(milliseconds: 100),
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

  await Future.wait([
    Hive.openBox('cache'),
    Hive.openBox('favorites'),
    Hive.openBox('settings'),
  ]);
}
