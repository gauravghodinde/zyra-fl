import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zyra/components/overlaysnackbar.dart';
import 'package:zyra/model/user.dart';
import 'package:zyra/pages/home/homepage.dart';
import 'package:zyra/pages/login/components/label_textbox.dart';
import 'package:zyra/pages/splash/components/background.dart';
import 'package:zyra/providers/userProvider.dart';

class OtpPage extends StatefulWidget {
  final User user;
  const OtpPage({super.key, required this.user});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  String otp = "";

  @override
  void dispose() {
    // Clear all text controllers when the widget is disposed
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void validateOtp() async {
    final navigator = Navigator.of(context);
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    otp = _controllers.map((controller) => controller.text).join();
    if (otp == "1234") {
      showOverlayMessage(context, 'Correct OTP');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userProvider.setUserFromModel(widget.user);
      await prefs.setString(
        'user',
        jsonEncode(widget.user),
      );

      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } else {
      showOverlayMessage(context, 'Invalid Otp');
      _clearOtpFields();
    }
  }

  void _clearOtpFields() {
    // Clear all OTP fields
    for (var controller in _controllers) {
      controller.clear();
    }
    setState(() {
      otp = ""; // Reset the OTP string as well
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Background(),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 3),
                LabelTextbox(
                  heading: "Verification Code",
                  subHeading:
                      "We have sent the verification code to your Phone Number ${widget.user.phoneNumber}",
                ),
                Spacer(flex: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) {
                    return _buildOtpBox(_controllers[index]);
                  }),
                ),
                Spacer(flex: 1),
                GestureDetector(
                  onTap: _clearOtpFields, // Button to clear all OTP fields
                  child: Text("Clear OTP"),
                ),
                Spacer(flex: 1),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: validateOtp,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.orangeAccent, Colors.deepOrange],
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            BoxConstraints(minWidth: 150, minHeight: 50),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1),
                Spacer(flex: 2),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOtpBox(TextEditingController controller) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.orange, // Customize the border color
          width: 2,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: "", // Hide the counter text
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus(); // Move to the next field
          }
        },
      ),
    );
  }
}
