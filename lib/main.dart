import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dolarbot_app/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(DolarBotApp(savedThemeMode: savedThemeMode));
}

class DolarBotApp extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;

  const DolarBotApp({Key key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.red,
          accentColor: Colors.green[500],
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.grey[800],
            ),
            bodyText2: TextStyle(
              color: Colors.grey[800],
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      dark: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.red,
          accentColor: Colors.green[500],
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
            ),
            bodyText2: TextStyle(
              color: Colors.white,
            ),
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DolarBot App',
        theme: theme,
        darkTheme: darkTheme,
        home: Home(),
      ),
    );
  }
}
