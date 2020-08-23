import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pahambudaya/model/UserModel.dart';

class PhoneVerificationScreenMainView extends StatefulWidget {
  PhoneVerificationScreenMainView({Key key, this.user}) : super(key: key);
  final UserModel user;

  @override
  _PhoneVerificationScreenMainViewState createState() =>
      _PhoneVerificationScreenMainViewState(user);
}

class _PhoneVerificationScreenMainViewState
    extends State<PhoneVerificationScreenMainView> {
  final UserModel user;
  Duration duration = Duration(seconds: 60);
  String sms = '';
  String animation = 'phoneverification';

  _PhoneVerificationScreenMainViewState(this.user);

  Future userVerification(String mobile, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    void verificationComplete(PhoneAuthCredential credential) async {
      animation = 'succes';
      await auth.signInWithCredential(credential);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(
          'Success Verification ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }

    void verificationFailed(FirebaseAuthException e) async {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            'The provided phone number is not valid.',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).errorColor,
        ));
      }
    }

    await auth.verifyPhoneNumber(
        phoneNumber: mobile,
        verificationCompleted: (PhoneAuthCredential credential) {
          verificationComplete(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          verificationFailed(e);
        },
        codeSent: null,
        codeAutoRetrievalTimeout: null);
  }

  Future userResendCode(String mobile, BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    void codeAutoRetievalTimeout() async {}
    void codeSent() async {}
    await auth.verifyPhoneNumber(
        phoneNumber: mobile,
        verificationCompleted: null,
        verificationFailed: null,
        codeSent: (String verificationId, int resendToken) {
          String sms = '';
          var random = Random();
          for (int i = 0; i <= 6; i++) {
            var resultSMS = random.nextInt(10);
            sms = resultSMS.toString();
          }

          print(sms);
        },
        codeAutoRetrievalTimeout: null,
        timeout: duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            FlareActor(
              'assets/hp.flr',
              alignment: Alignment.center,
              animation: 'phoneverification',
            )
          ],
        ),
      ),
    );
  }
}
