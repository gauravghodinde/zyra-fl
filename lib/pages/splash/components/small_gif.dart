import 'dart:ffi';

import 'package:flutter/material.dart';

class SmallGif extends StatelessWidget {
  final String path;
  final int height;
  final double angle;
  const SmallGif(
      {super.key,
      required this.path,
      required this.height,
      required this.angle});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Image(
        image: AssetImage(path),
        height: MediaQuery.of(context).size.height / height,
      ),
    );
  }
}
