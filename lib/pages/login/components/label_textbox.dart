import 'package:flutter/material.dart';

class LabelTextbox extends StatelessWidget {
  final String heading;
  final String subHeading;
  final String? para;
  const LabelTextbox(
      {super.key, required this.heading, required this.subHeading, this.para});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            heading,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            subHeading,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w200,
            ),
          ),
        ),
        (para != null)
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  para as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              )
            : Text("")
      ],
    );
  }
}
