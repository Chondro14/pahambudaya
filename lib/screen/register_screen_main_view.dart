import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pahambudaya/model/UserModel.dart';
import 'package:pahambudaya/screen/privacy_policy_screen_main_view.dart';
import 'package:pahambudaya/screen/verification_screen_main_view.dart';

class RegisterScreenMainView extends StatefulWidget {
  RegisterScreenMainView({Key key}) : super(key: key);

  @override
  _RegisterScreenMainViewState createState() => _RegisterScreenMainViewState();
}

class _RegisterScreenMainViewState extends State<RegisterScreenMainView> {
  final GlobalKey<FormState> _formRegister = GlobalKey<FormState>();
  final TextEditingController _formName = TextEditingController();
  final TextEditingController _formEmail = TextEditingController();
  final TextEditingController _formPhoneNumber = TextEditingController();
  final TextEditingController _passRegister = TextEditingController();
  final TextEditingController _confirmPassRegister = TextEditingController();
  bool obsecuretext = true;
  String userName;
  String userEmail;
  String userPhoneNumber;
  String userPassword;
  String userConfirmationPassword;
  String weakPassword;
  String error;
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  FirebaseAuth auth = FirebaseAuth.instance;

  void submitRegister(BuildContext context) async {
    final isValid = _formRegister.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formRegister.currentState.save();
      userName.trim();
      userConfirmationPassword.trim();
      userEmail.trim();
      userPassword.trim();
      userPhoneNumber.trim();

      try {
        UserCredential user = await auth.createUserWithEmailAndPassword(
            email: userEmail, password: userConfirmationPassword);
        User modelUser;
        UserModel(
            id: user.user.uid,
            nameUser: userName,
            emailUser: userEmail,
            phoneUser: userPhoneNumber,
            photoUser: user.user.photoURL);
        await FirebaseFirestore.instance.collection('users').add({
          'name': userName,
          'phonenumber': userPhoneNumber,
          'email': userEmail,
          'password': userPassword,
          'uid': user.user.uid
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VerificationScreenMainView(
                      user: modelUser,
                      phoneNumber: userPhoneNumber,
                    )));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          error = 'The Password provided is too weak';
          print('The Password provided is too weak');

          scaffold.currentState.showSnackBar(SnackBar(
            content: Text(
              error,
              style: TextStyle(color: Colors.white),
            ),
          ));
        } else if (e.code == 'email-already-in-use') {
          error = 'The account already exists for the email';
          print('The account already exists for the email');
          scaffold.currentState.showSnackBar(SnackBar(
            content: Text(
              error,
              style: TextStyle(color: Colors.white),
            ),
          ));
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: AppBar(
          backgroundColor: Colors.yellow[800],
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              })),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 48, 0, 0),
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Register Account",
                      style: TextStyle(color: Colors.yellow[800], fontSize: 24),
                    )),
              ),
              Form(
                  key: _formRegister,
                  autovalidate: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _formName,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            userName = value;
                          },
                          decoration: InputDecoration(
                              hintText: 'Your Name', labelText: 'Full Name'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _formEmail,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            userEmail = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email...', labelText: 'Email'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _formPhoneNumber,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number';
                            } else if (value.length < 10) {
                              return 'Please enter 11 digits phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userPhoneNumber = value;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: 'Your Phone number...',
                              labelText: 'Phone Number'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _passRegister,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value.length < 7) {
                              return 'Please your password too short,minimum 7 words';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userPassword = value;
                          },
                          obscureText: obsecuretext,
                          decoration: InputDecoration(
                              hintText: 'Password...',
                              labelText: 'Password',
                              suffixIcon: FlatButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      obsecuretext = !obsecuretext;
                                    });
                                  },
                                  icon: new Icon(obsecuretext
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  label: new Text(
                                      obsecuretext ? "Show" : "Hide"))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          controller: _confirmPassRegister,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            } else if (value != _passRegister.text) {
                              return 'Please enter your same password with before';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            userConfirmationPassword = value;
                          },
                          obscureText: obsecuretext,
                          decoration: InputDecoration(
                              hintText: 'Password...',
                              labelText: 'Confirmation Password',
                              suffixIcon: FlatButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      obsecuretext = !obsecuretext;
                                    });
                                  },
                                  icon: new Icon(obsecuretext
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  label: new Text(
                                      obsecuretext ? "Show" : "Hide"))),
                        ),
                      ),
                      CheckboxListTile(
                          value: false,
                          onChanged: (value) {},
                          title: Row(
                            children: [
                              Text(
                                "Click Agree for Agreement Policy ",
                                style: TextStyle(color: Colors.black),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PrivacyPolicyScreenMainView()));
                                  });
                                },
                                child: Text(
                                  "here",
                                  style: TextStyle(color: Colors.yellow[800]),
                                ),
                              )
                            ],
                          ))
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      submitRegister(context);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow[800],
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    height: MediaQuery.of(context).size.height / 15,
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
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
