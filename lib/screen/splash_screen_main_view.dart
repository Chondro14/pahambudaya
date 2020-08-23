import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pahambudaya/screen/login_screen_main_view.dart';

class SplashScreenMainView extends StatefulWidget {
  SplashScreenMainView({Key key}) : super(key: key);

  @override
  _SplashScreenMainViewState createState() => _SplashScreenMainViewState();
}

class _SplashScreenMainViewState extends State<SplashScreenMainView> {
  bool loading = true;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.yellow[800],
        child: FlareActor(
          'assets/Animations.flr',
          animation: 'AnimasiSaron',
          alignment: Alignment.center,
          callback: (String name) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreenMainView()));
          },
        ));
  }
}
