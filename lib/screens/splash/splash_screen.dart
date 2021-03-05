import 'package:dolarbot_app/classes/globals.dart';
import 'package:dolarbot_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:show_up_animation/show_up_animation.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _waitAndGoHome(context, 3);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(51, 148, 34, 1),
                      Color.fromRGBO(50, 177, 40, 1),
                      Color.fromRGBO(40, 245, 51, 1),
                    ]),
              ),
            ),
            //padding: EdgeInsets.only(bottom: 300),
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
                        SizedBox(
                          height: 25,
                        ),
                        ShowUpAnimation(
                          delayStart: Duration(milliseconds: 0),
                          animationDuration: Duration(seconds: 1),
                          curve: Curves.easeIn,
                          direction: Direction.vertical,
                          offset: 0,
                          child: Text(
                            'DolarBot',
                            style: TextStyle(
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
                      delayStart: Duration(milliseconds: 500),
                      animationDuration: Duration(milliseconds: 1500),
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
}

_waitAndGoHome(BuildContext context, int secondsToWait) {
  return Future.delayed(
    Duration(seconds: secondsToWait),
    () async {
      Globals.packageInfo = await PackageInfo.fromPlatform();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => HomeScreen(),
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation1, animation2, child) =>
              FadeTransition(
            opacity: animation1,
            child: child,
          ),
        ),
      );
    },
  );
}

class Footer extends StatelessWidget {
  const Footer({
    Key key,
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
            padding: EdgeInsets.all(35),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Una sola app.\nTodas las cotizaciones.",
              style: TextStyle(
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
