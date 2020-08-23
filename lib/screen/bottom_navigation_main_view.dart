import 'dart:math' as math;

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:pahambudaya/screen/feed_screen_main_view.dart';
import 'package:pahambudaya/screen/home_screen_main_view.dart';
import 'package:pahambudaya/screen/profile_screen_main_view.dart';
import 'package:pahambudaya/screen/schendule_screen_main_view.dart';
import 'package:pahambudaya/screen/shop_screen_main_view.dart';

class BottomNavigationMainView extends StatefulWidget {
  BottomNavigationMainView({Key key}) : super(key: key);

  @override
  _BottomNavigationMainViewState createState() =>
      _BottomNavigationMainViewState();
}

class _BottomNavigationMainViewState extends State<BottomNavigationMainView> {
  int screenPageIndex = 0;
  Color colorse = Colors.black45;
  String item = 'home';
  String active = 'home';

  Widget screenPage = new HomeScreenMainView();

  Widget ChooseScreen(int indexPage) {
    switch (indexPage) {
      case 0:
        return new HomeScreenMainView();
      case 1:
        return new SchenduleScreenMainView();
      case 2:
        return new ShopScreenMainView();

      case 3:
        return new FeedScreenMainView();
      case 4:
        return new ProfileScreenMainView();
    }
  }

  Color colorIcon(int indexPage) {
    switch (indexPage) {
      case 0:
        return Colors.yellow[700];
      case 1:
        return Colors.yellow[700];
      case 2:
        return Colors.yellow[700];
      case 3:
        return Colors.yellow[700];
      case 4:
        return Colors.yellow[700];
    }
  }

  void selectIconAnimation(int page) {}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(children: [
          HomeScreenMainView(),
          SchenduleScreenMainView(),
          FeedScreenMainView(),
          ProfileScreenMainView()
        ]),
        bottomNavigationBar:
            TabBar(indicatorColor: Colors.yellow[800], tabs: <Tab>[
          Tab(
            child: FlareActor(
              'assets/home.flr',
              alignment: Alignment.center,
              animation: 'hide',
            ),
          ),
          Tab(
            child: FlareActor(
              'assets/schendule.flr',
              alignment: Alignment.center,
              animation: 'hide',
            ),
          ),
          Tab(
            child: FlareActor('assets/feeds.flr',
                alignment: Alignment.center, animation: 'hide'),
          ),
          Tab(
            child: FlareActor('assets/profile.flr',
                alignment: Alignment.center, animation: 'hide'),
          )
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ChooseScreen(2);
          },
          child: FlareActor(
            'assets/shop.flr',
            alignment: Alignment.center,
            animation: 'hide',
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends NotchedShape {
  final double radius;

  CustomAppBar(this.radius);

  @override
  Path getOuterPath(Rect host, Rect guest) {
    if (guest == null || !host.overlaps(guest)) return Path()..addRect(host);

    // The guest's shape is a circle bounded by the guest rectangle.
    // So the guest's radius is half the guest width.
    final notchRadius = guest.width / 2.0;

    const s1 = 15.0;
    const s2 = 1.0;

    final r = notchRadius;
    final a = -1.0 * r - s2;
    final b = host.top - guest.center.dy;

    final n2 = math.sqrt(b * b * r * r * (a * a + b * b - r * r));
    final p2xA = ((a * r * r) - n2) / (a * a + b * b);
    final p2xB = ((a * r * r) + n2) / (a * a + b * b);
    final p2yA = -math.sqrt(r * r - p2xA * p2xA);
    final p2yB = -math.sqrt(r * r - p2xB * p2xB);

    final p = List<Offset>(6);

    // p0, p1, and p2 are the control points for segment A.
    p[0] = Offset(a - s1, b);
    p[1] = Offset(a, b);
    final cmp = b < 0 ? -1.0 : 1.0;
    p[2] = cmp * p2yA > cmp * p2yB ? Offset(p2xA, p2yA) : Offset(p2xB, p2yB);

    // p3, p4, and p5 are the control points for segment B, which is a mirror
    // of segment A around the y axis.
    p[3] = Offset(-1.0 * p[2].dx, p[2].dy);
    p[4] = Offset(-1.0 * p[1].dx, p[1].dy);
    p[5] = Offset(-1.0 * p[0].dx, p[0].dy);

    // translate all points back to the absolute coordinate system.
    for (var i = 0; i < p.length; i += 1) {
      p[i] += guest.center;
      //p[i] += padding;
    }

    return (radius ?? 0) > 0
        ? (Path()
          ..moveTo(host.left, host.top + radius)
          ..arcToPoint(Offset(host.left + radius, host.top),
              radius: Radius.circular(radius))
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(
            p[3],
            radius: Radius.circular(notchRadius),
            clockwise: true,
          )
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.right - radius, host.top)
          ..arcToPoint(Offset(host.right, host.top + radius),
              radius: Radius.circular(radius))
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close())
        : (Path()
          ..moveTo(host.left, host.top)
          ..lineTo(p[0].dx, p[0].dy)
          ..quadraticBezierTo(p[1].dx, p[1].dy, p[2].dx, p[2].dy)
          ..arcToPoint(
            p[3],
            radius: Radius.circular(notchRadius),
            clockwise: true,
          )
          ..quadraticBezierTo(p[4].dx, p[4].dy, p[5].dx, p[5].dy)
          ..lineTo(host.right, host.top)
          ..lineTo(host.right, host.bottom)
          ..lineTo(host.left, host.bottom)
          ..close());
  }
}
