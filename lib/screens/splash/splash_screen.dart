import 'package:dolarbot_app/classes/globals.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:show_up_animation/show_up_animation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _waitAndGoHome(context, const Duration(milliseconds: 4000));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                  const Color.fromRGBO(51, 148, 34, 1),
                  const Color.fromRGBO(50, 177, 40, 1),
                  const Color.fromRGBO(40, 245, 51, 1),
                ]),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment: FractionalOffset.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logos/d.png',
                          scale: 3.0,
                          height: 124,
                          width: 124,
                          filterQuality: FilterQuality.high,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ShowUpAnimation(
                          delayStart: Duration.zero,
                          animationDuration: const Duration(seconds: 1),
                          curve: Curves.easeIn,
                          direction: Direction.vertical,
                          offset: 0,
                          child: const Text(
                            'DolarBot',
                            style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Raleway',
                                letterSpacing: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ShowUpAnimation(
                      delayStart: const Duration(milliseconds: 500),
                      animationDuration: const Duration(milliseconds: 1500),
                      direction: Direction.vertical,
                      offset: 2,
                      child: Footer(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _waitAndGoHome(BuildContext context, Duration waitToHome) {
    return WidgetsBinding.instance!.addPostFrameCallback(
      (_) => Future.delayed(
        waitToHome,
        () async {
          Globals.packageInfo = await PackageInfo.fromPlatform();
          await Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => HomeScreen(
                key: GlobalKey<HomeScreenState>(),
              ),
              transitionDuration: const Duration(milliseconds: 300),
              transitionsBuilder: (context, animation1, animation2, child) => FadeTransition(
                opacity: animation1,
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/general/splash_footer.png',
              width: double.infinity,
              height: 120,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(35),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Una app.\nTodas las cotizaciones.",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                fontFamily: 'Raleway',
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
