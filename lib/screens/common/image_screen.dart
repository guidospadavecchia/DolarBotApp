import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final ImageProvider<Object> image;
  final String text;
  final TextStyle textStyle;
  final double textOpacity;
  final Color imageColor;
  final BlendMode imageColorFilterBlendMode;
  final double? imageHeight;
  final double imageOpacity;
  final EdgeInsets containerPadding;

  const ImageScreen({
    Key? key,
    required this.image,
    this.text = '',
    this.textStyle = const TextStyle(fontSize: 20, fontFamily: "Raleway"),
    this.textOpacity = 1,
    this.imageColor = Colors.white,
    this.imageColorFilterBlendMode = BlendMode.srcATop,
    this.imageHeight,
    this.imageOpacity = 1,
    this.containerPadding = const EdgeInsets.all(20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: containerPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: imageOpacity,
            child: Container(
              height: imageHeight ?? MediaQuery.of(context).size.height / 5,
              decoration: BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(imageColor, imageColorFilterBlendMode),
                  image: image,
                ),
              ),
            ),
          ),
          if (text != '')
            const SizedBox(
              height: 50,
            ),
          if (text != '')
            Opacity(
              opacity: textOpacity,
              child: Text(
                text,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
