import 'dart:async';

import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zarconydemoapp/tools/general.dart';
import 'package:zarconydemoapp/tools/size_config.dart';

import 'PhoneVerifyCode.dart';

class PhoneVerify extends StatefulWidget {
  @override
  _PhoneVerifyState createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {
  String countryCode = '+20';
  TextEditingController phoneNumber = TextEditingController();

  final StreamController<PhoneAuthCredential> _verifySuccessStream =
      StreamController<PhoneAuthCredential>.broadcast();

  bool isLoading = false;

  @override
  void dispose() {
    _verifySuccessStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff0174BB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(top: SizeConfig.heightScreenSize * 0.15),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
//                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'OTP Authentication',
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
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    print('[hiiii]');
                                    showCountryPicker(
                                      context: context,
                                      showPhoneCode:
                                          true, // optional. Shows phone code before the country name.
                                      onSelect: (Country country) {
                                        setState(() {
                                          countryCode = "+" + country.phoneCode;
                                        });
                                        print(
                                            'Select country: ${country.displayName}');
                                      },
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(countryCode),
                                      Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                )),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  child: TextField(
                                    controller: phoneNumber,
                                  ),
                                )),
                          ],
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
                          _loginSMS(context);
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
                                  'Next',
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
        ));
  }

  Future<void> _loginSMS(context) async {
    if (phoneNumber == null) {
      failMessage('Enter phone number', context);
    } else {
      setState(() {
        isLoading = true;
      });
      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {};

      final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
        setState(() {
          isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneVerifyCode(
              verId: verId,
              phoneNumber: phoneNumber.text,
              verifySuccessStream: _verifySuccessStream.stream,
            ),
          ),
        );
      };

      final PhoneVerificationCompleted verifiedSuccess =
          _verifySuccessStream.add;

      final PhoneVerificationFailed veriFailed =
          (FirebaseAuthException exception) {
        print('exception.message : ${exception.message}');
        failMessage(exception.message, context);
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumber.text,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 120),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed,
      );
    }
  }
}
