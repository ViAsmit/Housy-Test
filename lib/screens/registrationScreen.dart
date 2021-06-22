import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:housy_test/screens/LandingScreen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
String _verificationId = "";

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController otpCtl = TextEditingController();
  bool showOtp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            Text(
              "Enter Your Number",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextField(
                readOnly: showOtp,
                controller: phoneCtl,
                textAlign: TextAlign.center,
                cursorHeight: 30.0,
                style: Theme.of(context).textTheme.bodyText1,
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.5),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1.5),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              onPressed: () async {
                setState(() {
                  showOtp = true;
                });
                try {
                  await _auth.verifyPhoneNumber(
                      phoneNumber: "+91${phoneCtl.text}",
                      timeout: const Duration(seconds: 5),
                      verificationCompleted: verificationCompleted,
                      verificationFailed: verificationFailed,
                      codeSent: codeSent,
                      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
                } catch (e) {
                  print("Failed to Verify Phone Number: $e");
                }
              },
              child: Text("Proceed"),
            ),
            if (showOtp) SizedBox(height: 40.0),
            if (showOtp)
              Text(
                "Enter OTP",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            if (showOtp) SizedBox(height: 20.0),
            if (showOtp)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: TextField(
                  controller: otpCtl,
                  textAlign: TextAlign.center,
                  cursorHeight: 30.0,
                  style: Theme.of(context).textTheme.bodyText1,
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.5),
                    ),
                  ),
                ),
              ),
            if (showOtp) SizedBox(height: 20.0),
            if (showOtp)
              RaisedButton(
                onPressed: () async {
                  try {
                    final AuthCredential credential =
                        PhoneAuthProvider.credential(
                      verificationId: _verificationId,
                      smsCode: otpCtl.text,
                    );

                    final User? user =
                        (await _auth.signInWithCredential(credential)).user;
                    print("=================");
                    print("Successfully signed in UID: ${user?.uid}");
                    print("=================");

                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => LandingScreen(),
                        ),
                        (route) => false);
                  } catch (e) {
                    print("Failed to sign in: " + e.toString());
                  }
                },
                child: Text("Go"),
              ),
          ],
        ),
      ),
    );
  }
}

PhoneVerificationCompleted verificationCompleted =
    (PhoneAuthCredential phoneAuthCredential) async {
  await _auth.signInWithCredential(phoneAuthCredential);
  print(
      "Phone number automatically verified and user signed in: ${_auth.currentUser?.uid}");
};

PhoneVerificationFailed verificationFailed =
    (FirebaseAuthException authException) {
  print(
      'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
};

PhoneCodeSent codeSent = (String verificationId, int? resendToken) async {
  print('Please check your phone for the verification code.');
  _verificationId = verificationId;
};

PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
    (String verificationId) {
  print("verification code: " + verificationId);
  _verificationId = verificationId;
};
