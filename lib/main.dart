import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/classes/hive/adapters/cache_entry_adapter.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:dolarbot_app/screens/options/options_screen.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:dolarbot_app/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await GlobalConfiguration().loadFromAsset("app_settings");
  initializeHive();
  runApp(DolarBotApp(savedThemeMode: savedThemeMode));
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
      builder: (lightTheme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DolarBot',
          theme: lightTheme,
          darkTheme: darkTheme,
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            "/o": (BuildContext context) => OptionsScreen()
          }),
    );
  }
}

void initializeHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CacheEntryAdapter());
  await Hive.openBox('cache');
}
