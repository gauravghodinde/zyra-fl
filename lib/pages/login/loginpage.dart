import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zyra/components/overlaysnackbar.dart';
import 'package:zyra/model/user.dart';
import 'package:zyra/pages/login/components/label_textbox.dart';
import 'package:zyra/pages/login/otp_page.dart';
import 'package:zyra/pages/splash/components/background.dart';
import 'package:zyra/pages/splash/components/floating_gifs.dart';
import 'package:zyra/pages/splash/components/logo.dart';
import 'package:zyra/providers/userProvider.dart';
import 'package:zyra/utils/constants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();
    void validatePhoneNumber() {
      final navigator = Navigator.of(context);
      String phone = phoneController.text.trim();

      if (RegExp(r'^\d{10}$').hasMatch(phone)) {
        showOverlayMessage(context, 'OTP had been sent');
        navigator.push(
          MaterialPageRoute(
            builder: (context) => OtpPage(
              user: User(
                id: '1',
                phoneNumber: '${phone}',
              ),
            ),
          ),
        );
      } else {
        showOverlayMessage(
            context, 'Please enter a valid 10-digit phone number.');
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Background(),
          FloatingGifs(),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(flex: 3),
                Center(
                  child: Logo(),
                ),
                Spacer(flex: 1),
                LabelTextbox(
                  heading: 'OTP Verification',
                  subHeading: 'Enter phone number to send one time Password',
                ),
                Spacer(flex: 1),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: EdgeInsets.all(15),
                    prefixText: '+91 ',
                    prefixStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                        color: Colors.orange,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1),
                ElevatedButton(
                  onPressed: validatePhoneNumber,
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
                      constraints: BoxConstraints(minWidth: 150, minHeight: 50),
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
                Spacer(flex: 3),
              ],
            ),
          )
        ],
      ),
    );
  }
}
