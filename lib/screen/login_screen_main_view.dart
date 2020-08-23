import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pahambudaya/screen/bottom_navigation_main_view.dart';
import 'package:pahambudaya/screen/register_screen_main_view.dart';

class LoginScreenMainView extends StatefulWidget {
  LoginScreenMainView({Key key}) : super(key: key);

  @override
  _LoginScreenMainViewState createState() => _LoginScreenMainViewState();
}

class _LoginScreenMainViewState extends State<LoginScreenMainView> {
  bool obsecuretext = false;
  final GlobalKey<FormState> _formLogin = GlobalKey<FormState>();
  final TextEditingController emailUser = TextEditingController();
  final TextEditingController passwordUser = TextEditingController();
  GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
  String email;
  String password;

  Future<void> sumbitLogin(BuildContext context) async {
    final isValid = _formLogin.currentState.validate();
    if (isValid) {
      try {
        _formLogin.currentState.save();
        email = emailUser.text.trim();
        password = passwordUser.text.trim();
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigationMainView()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          scaffold.currentState.showSnackBar(
              SnackBar(content: Text('No user found for that email.')));

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          scaffold.currentState.showSnackBar(SnackBar(
              content: Text('Wrong password provided for that user.')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      body: Container(
        decoration: BoxDecoration(color: Colors.yellow[800]),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, -230),
              child: FlareActor(
                'assets/Animations.flr',
                animation: 'AnimasiSaron',
                alignment: Alignment.center,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      boxShadow: [BoxShadow()]),
                  child: Form(
                    key: _formLogin,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.yellow[800]),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: emailUser,
                            onSaved: (value) {
                              this.email = value;
                            },
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Please enter your valid email address';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Email...', labelText: 'Email'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: passwordUser,
                            onSaved: (value) {
                              this.password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreenMainView()));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow[800],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  child: Center(
                                    child: Text('Register'),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    sumbitLogin(context);
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 4,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  child: Center(
                                    child: Text(
                                      'Login',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
