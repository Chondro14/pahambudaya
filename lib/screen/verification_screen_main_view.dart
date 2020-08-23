import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pahambudaya/screen/home_screen_main_view.dart';

class VerificationScreenMainView extends StatefulWidget {
  VerificationScreenMainView(
      {Key key, @required this.user, @required this.phoneNumber})
      : super(key: key);
  User user;
  final String phoneNumber;

  @override
  _VerificationScreenMainViewState createState() =>
      _VerificationScreenMainViewState(user: user, phoneNumber: phoneNumber);
}

class _VerificationScreenMainViewState
    extends State<VerificationScreenMainView> {
  _VerificationScreenMainViewState(
      {@required this.phoneNumber, @required this.user});

  User user;

  final String phoneNumber;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController OTPcode = TextEditingController();
  String smsCode, verificationId;

  get verifiedSuccess => null;
  String animation = 'phoneverification';
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  Future<bool> verifyphone(
      BuildContext context, String phonenumber, String smsCode) async {
    final PhoneCodeAutoRetrievalTimeout timeout = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent =
        (String verId, [int forceCodeResent]) async {
      this.verificationId = verId;
      Random value = Random();

      int a = value.nextInt(9);
      int b = value.nextInt(9);
      int c = value.nextInt(9);
      int d = value.nextInt(9);
      int e = value.nextInt(9);
      try {
        smsCode = a.toString() +
            b.toString() +
            c.toString() +
            d.toString() +
            e.toString();
        smsCodeDialoge(context, smsCode).then((value) async {
          PhoneAuthCredential phoneAuthCredential =
              PhoneAuthProvider.credential(
                  verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await auth.signInWithCredential(phoneAuthCredential);
        });

        // ...
      } on PlatformException catch (e) {
        if (e.message.contains(
            'The sms verification code used to create the phone auth credential is invalid')) {
          scaffold.currentState.showSnackBar(SnackBar(
              content: Text(
                  'The sms verification code used to create the phone auth credential is invalid')));
          // ...
        } else if (e.message.contains('The sms code has expired')) {
          scaffold.currentState.showSnackBar(
              SnackBar(content: Text('The sms code has expired')));
          // ...
        }
      }

      // Sign the user in (or link) with the credential
    };
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
      auth.setLanguageCode('id');
      FirebaseUser user;
      animation = 'succes';
      if (user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreenMainView()));
        scaffold.currentState
            .showSnackBar(SnackBar(content: Text('Succes OTP')));
      }
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      if (exception.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
        animation = 'failed';
        scaffold.currentState.showSnackBar(
            SnackBar(content: Text('The provided phone number is not valid.')));
      }
      animation = 'failed';
    };
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: smsCodeSent,
          codeAutoRetrievalTimeout: timeout);
    } on PlatformException catch (e) {
      if (e.message.contains(
          'The sms verification code used to create the phone auth credential is invalid')) {
        scaffold.currentState.showSnackBar(SnackBar(
            content: Text(
                'The sms verification code used to create the phone auth credential is invalid')));
        // ...
      } else if (e.message.contains('The sms code has expired')) {
        scaffold.currentState
            .showSnackBar(SnackBar(content: Text('The sms code has expired')));
        // ...
      }
    }
  }

  Future<bool> smsCodeDialoge(BuildContext context, String smsCode) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[800],
          title: Text('Enter OTP'),
          content: TextField(
            controller: OTPcode,
            onChanged: (value) {
              this.smsCode = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Verify'),
              onPressed: () async {
                smsCode = OTPcode.text.trim();
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: smsCode);
                  await auth.signInWithCredential(credential);
                  user = FirebaseAuth.instance.currentUser;
                  ;
                  if (user != null) {
                    Navigator.of(context).pop();
                    scaffold.currentState
                        .showSnackBar(SnackBar(content: Text('Succes OTP')));
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreenMainView()));
                  }
                } on PlatformException catch (e) {
                  if (e.message.contains(
                      'The sms verification code used to create the phone auth credential is invalid')) {
                    scaffold.currentState.showSnackBar(SnackBar(
                        content: Text(
                            'The sms verification code used to create the phone auth credential is invalid')));
                    // ...
                  } else if (e.message.contains('The sms code has expired')) {
                    scaffold.currentState.showSnackBar(
                        SnackBar(content: Text('The sms code has expired')));
                    // ...
                  }
                }

                // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.yellow[800],
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: FlareActor(
                      'assets/hp.flr',
                      alignment: Alignment.center,
                      animation: animation,
                    )),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    verifyphone(context, phoneNumber, smsCode);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: MediaQuery.of(context).size.height / 15,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 4),
                          child: Icon(
                            Icons.smartphone,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Verification PhoneNumber'),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
