import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zarconydemoapp/tools/general.dart';
import 'package:zarconydemoapp/tools/size_config.dart';
import 'Home.dart';

class PhoneVerifyCode extends StatefulWidget {
  String phoneNumber, verId;
  final Stream<firebase_auth.PhoneAuthCredential> verifySuccessStream;
  PhoneVerifyCode({this.phoneNumber, this.verId, this.verifySuccessStream});

  @override
  _PhoneVerifyCodeState createState() => _PhoneVerifyCodeState();
}

class _PhoneVerifyCodeState extends State<PhoneVerifyCode> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _pinCodeController = TextEditingController();

  bool hasError = false;
  String currentText = "";
  var onTapRecognizer;
  Future<void> _verifySuccessStreamListener(
      firebase_auth.PhoneAuthCredential credential) async {
    if (credential != null && mounted) {
      setState(() {
        _pinCodeController.text = credential.smsCode;
      });
//      Utils.hideKeyboard(context);
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }

  @override
  void initState() {
    widget.verifySuccessStream?.listen(_verifySuccessStreamListener);

    super.initState();
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
    } on TickerCanceled {
//      printLog('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
//      printLog('[_stopAnimation] error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0174BB),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: SizeConfig.heightScreenSize * 0.15),
              child: Text(
                'Getting Started',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'Create an account to continued',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Your OPT Code Here',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 15,
                        color: const Color(0xff828282),
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Container(
                      height: 50,
                      child: PinCodeTextField(
                        appContext: context,
                        controller: _pinCodeController,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(9),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Theme.of(context).backgroundColor,
                        ),
                        length: 6,
                        autoFocus: true,
                        animationType: AnimationType.fade,
                        animationDuration: const Duration(milliseconds: 300),
                        onChanged: (value) {
                          if (value != null && value.length == 6) {
                            _loginSMS(value, context);
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      color: const Color(0xfffd8700),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
//                            side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {
                        _loginSMS(_pinCodeController.text, context);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Verfy',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                                textAlign: TextAlign.left,
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginSMS(smsCode, context) async {
    await _playAnimation();
    try {
      final firebase_auth.AuthCredential credential =
          firebase_auth.PhoneAuthProvider.credential(
        verificationId: widget.verId,
        smsCode: smsCode,
      );

      await _signInWithCredential(credential);
    } catch (e) {
      await _stopAnimation();
//      failMessage(e.toString(), context);
    }
  }

  Future<void> _signInWithCredential(
      firebase_auth.PhoneAuthCredential credential) async {
    final firebase_auth.User user = (await firebase_auth.FirebaseAuth.instance
            .signInWithCredential(credential))
        .user;
    if (user != null) {
      await _stopAnimation();
      _startHomePage();
    } else {
      failMessage("invalidSMSCode", context);
    }
  }

  void _startHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => Home()),
        (Route<dynamic> route) => false);
  }
}
