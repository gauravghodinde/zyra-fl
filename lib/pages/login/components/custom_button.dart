import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final double width;
  final String text;

  const CustomButton({super.key, required this.width, required this.text});
  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * widget.width;

    return ElevatedButton(
      onPressed: isClicked
          ? null
          : () {
              setState(() {
                isClicked = true;
              });
            },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: isClicked ? Colors.black : Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: isClicked
              ? null
              : LinearGradient(
                  colors: [Colors.orangeAccent, Colors.deepOrange],
                ),
          color: isClicked ? Colors.black : null,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          alignment: Alignment.center,
          height: 50,
          child: Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
