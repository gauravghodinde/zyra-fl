import 'package:flutter/material.dart';
import 'package:zyra/pages/splash/components/small_gif.dart';

class FloatingGifsTop extends StatelessWidget {
  const FloatingGifsTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Transform.translate(
          offset: Offset(-8, 14),
          child: SmallGif(
            path: "assets/gif/cloths.gif",
            height: 10,
            angle: -0.5,
          ),
        ),
        Transform.translate(
          offset: Offset(5, -14),
          child: SmallGif(
            path: "assets/gif/cloths.gif",
            height: 10,
            angle: 0.5,
          ),
        ),
      ],
    );
  }
}

class FloatingGifs extends StatelessWidget {
  const FloatingGifs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(flex: 1),
            FloatingGifsTop(),
            Spacer(flex: 3),
            // FloatingGifsCenter(),
            // Spacer(flex: 2),
            // FloatingGifsBotttom(),
            Spacer(flex: 1),
          ],
        ));
  }
}

class FloatingGifsBotttom extends StatelessWidget {
  const FloatingGifsBotttom({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Transform.translate(
          offset: Offset(5, 4),
          child: SmallGif(
            path: "assets/gif/cloths.gif",
            height: 15,
            angle: -0.3,
          ),
        ),
        Transform.translate(
          offset: Offset(1, 20),
          child: SmallGif(
            path: "assets/gif/cloths.gif",
            height: 12,
            angle: 0.2,
          ),
        ),
      ],
    );
  }
}

class FloatingGifsCenter extends StatelessWidget {
  const FloatingGifsCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Transform.translate(
          offset: Offset(-18, 4),
          child: SmallGif(
            path: "assets/gif/cloths.gif",
            height: 14,
            angle: 0.2,
          ),
        ),
        Transform.translate(
          offset: Offset(15, -4),
          child: SmallGif(
            path: "assets/gif/cloths.gif",
            height: 12,
            angle: -0.18,
          ),
        ),
      ],
    );
  }
}
