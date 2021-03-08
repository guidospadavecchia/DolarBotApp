import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dolarbot_app/classes/theme_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:simple_animations/simple_animations.dart';

class EmptyFavorites extends StatelessWidget {
  final String topText;
  final String bottomText;
  final double imageOpacity;
  final double textOpacity;

  const EmptyFavorites({
    Key key,
    this.topText,
    this.bottomText,
    this.imageOpacity = 0.4,
    this.textOpacity = 0.8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = Hive.box('settings');
    bool isFirstTime = settings.get('firstTime') == null ? true : false;
    if (isFirstTime) settings.put('firstTime', true);
    isFirstTime = true;

    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            if (isFirstTime)
              Opacity(
                opacity: textOpacity,
                child: Text(
                  topText ?? "¡Hola 👋!\n",
                  style: TextStyle(
                      fontSize: 36,
                      fontFamily: "Raleway",
                      color: ThemeManager.getPrimaryTextColor(context)
                          .withOpacity(1)),
                  textAlign: TextAlign.center,
                ),
              ),
            Opacity(
              opacity: textOpacity,
              child: Text(
                topText ?? isFirstTime
                    ? "Para que sepas, este será tu inicio, y aquí aparecerán tus cotizaciones favoritas."
                    : "¡Aquí aparecerán tus cotizaciones favoritas!",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context)
                        .withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 50),
            Opacity(
              opacity: imageOpacity,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Image.asset("assets/images/general/home_bg.png"),
              ),
            ),
            SizedBox(height: 50),
            Opacity(
              opacity: textOpacity,
              child: Text(
                bottomText ?? isFirstTime
                    ? "Vas a poder tener, en un sólo lugar, las cotizaciones que más se ajusten a tus necesidades, en forma de tarjetas."
                    : "Ahora mismo no tenés ninguna.\nPodés dirigirte a cualquier cotización y agregarla desde allí.",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Raleway",
                    color: ThemeManager.getPrimaryTextColor(context)
                        .withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}

class FirstTimeDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10, width: 2),
          gradient: AdaptiveTheme.of(context).brightness == Brightness.dark
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(14, 24, 29, 1),
                    Color.fromRGBO(14, 24, 29, 0.4)
                  ],
                )
              : null,
        ),
        child: CarouselSlider(
          options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.7,
              enableInfiniteScroll: false,
              viewportFraction: 1),
          items: [_step(0), _step(1), _step(2), _step(3)].map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return i;
                },
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}

Widget _getStepTitle(BuildContext context, int step, String title) {
  return Stack(
    children: [
      Padding(
        padding:
            const EdgeInsets.only(left: 40, top: 26, bottom: 15, right: 20),
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 35,
          margin: EdgeInsets.only(left: 25),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
            color: ThemeManager.getPrimaryAccentColor(context),
          ),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                color: ThemeManager.getGlobalBackgroundColor(context),
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ThemeManager.getPrimaryAccentColor(context),
          ),
          child: Center(
            child: Text(
              step.toString(),
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22,
                  color: ThemeManager.getGlobalBackgroundColor(context),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _step(int stepIndex) {
  return IndexedStack(
    index: stepIndex,
    children: [
      StepOne(),
      StepTwo(),
      StepThree(),
      StepFour(),
    ],
  );
}

Widget _buildStepFooter(BuildContext context) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      decoration: BoxDecoration(
        color: ThemeManager.getPrimaryAccentColor(context),
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(8),
          right: Radius.circular(8),
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
      width: double.infinity,
      height: 12,
    ),
  );
}

class StepOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getStepTitle(context, 1, "Bienvenido"),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "¡Hola! 👋",
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: "Raleway",
                  color: ThemeManager.getPrimaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Esta es la primera vez que abrís la aplicación.\n\nVeamos qué es lo que podés hacer con ella...",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Raleway",
                  color: ThemeManager.getPrimaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        _buildStepFooter(context),
      ],
    );
  }
}

class StepTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getStepTitle(context, 2, "Favoritos / Tarjetas"),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Podés agregar tus cotizaciones favoritas al inicio de la aplicación, lo que llamamos \"tarjetas\".",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: ThemeManager.getPrimaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 256,
                height: 256,
                child: Image.asset(
                  "assets/images/general/menu_fav.png",
                  width: 256,
                  height: 256,
                  filterQuality: FilterQuality.high,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Para ello, entrá a la cotización que quieras y, luego, tocá en el ♥ que está dentro del menú de abajo a la derecha.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: ThemeManager.getPrimaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        _buildStepFooter(context),
      ],
    );
  }
}

class StepThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getStepTitle(context, 3, "Inicio"),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Las tarjetas que agregues aparecerán una debajo de la otra.\n\n¡No hay límite,\npodés agregar cuántas quieras!",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: ThemeManager.getPrimaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: 256,
                height: 256,
                child: Image.asset(
                  "assets/images/general/home_bg.png",
                  width: 256,
                  height: 256,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Text(
                "También podés quitarlas, obviamente.\nSimplemente tocá en la ❌ que está ubicada arriba a la derecha de la tarjeta.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: ThemeManager.getPrimaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        _buildStepFooter(context),
      ],
    );
  }
}

class StepFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _getStepTitle(context, 4, "Compartir Cotización"),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "¡Podés compartir cualquier cotización instantáneamente como una tarjeta!\n\nY pueden ser tanto las que están en tu Inicio como las que no.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: ThemeManager.getPrimaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 256,
                height: 256,
                child: Image.asset(
                  "assets/images/general/menu_share.png",
                  width: 256,
                  height: 256,
                  filterQuality: FilterQuality.high,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Presioná ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto",
                      color: ThemeManager.getPrimaryTextColor(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Icon(
                    Icons.share,
                    color: ThemeManager.getPrimaryAccentColor(context),
                  ),
                  Text(
                    " ya sea desde el menú ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto",
                      color: ThemeManager.getPrimaryTextColor(context),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text(
                "de la cotización. O bien, desde la tarjeta, ubicado arriba a la derecha.",
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  color: ThemeManager.getPrimaryTextColor(context),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        _buildStepFooter(context),
      ],
    );
  }
}
