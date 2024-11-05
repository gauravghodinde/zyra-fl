import 'package:flutter/material.dart';
import 'package:zyra/utils/uitheme.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/gif/background.gif'),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      fit: BoxFit.fill,
      opacity: AlwaysStoppedAnimation(
          Theme.of(context).extension<Custom>()?.backgroundImageOpacity ??
              0.15),
    );
  }
}
